package com.mkpenc.common.module;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.security.MessageDigest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Pattern;


public class StringUtil {
    // ~ Static fields/initializers
    // =============================================

    /** The <code>Log</code> instance for this class. */
    private static Logger log = LoggerFactory.getLogger(StringUtil.class);

    private static final String DOT = ".";

    // ~ Methods
    // ================================================================

    private StringUtil() {
    }

    /**
     * Encode a string using algorithm specified in web.xml and return the resulting encrypted password. If exception, the plain credentials
     * string is returned
     *
     * @param password
     *            Password or other credentials to use in authenticating this username
     * @param algorithm
     *            Algorithm used to do the digest
     * @return encypted password based on the algorithm.
     */
    public static String encodePassword(String password, String algorithm) {
        byte[] unencodedPassword = password.getBytes();

        MessageDigest md = null;

        try {
            // first create an instance, given the provider
            md = MessageDigest.getInstance(algorithm);
        } catch (Exception e) {
            log.error("Exception: " + e);

            return password;
        }

        md.reset();

        // call the update method one or more times
        // (useful when you don't know the size of your data, eg. stream)
        md.update(unencodedPassword);

        // now calculate the hash
        byte[] encodedPassword = md.digest();

        StringBuffer buf = new StringBuffer();

        for (int i = 0; i < encodedPassword.length; i++) {
            if ((encodedPassword[i] & 0xff) < 0x10) {
                buf.append("0");
            }

            buf.append(Long.toString(encodedPassword[i] & 0xff, 16));
        }

        return buf.toString();
    }

    /**
     * Encode a string using Base64 encoding. Used when storing passwords as cookies. This is weak encoding in that anyone can use the
     * decodeString routine to reverse the encoding.
     *
     * @param str
     *            String to be encoded
     * @return String encoding result

    public static String encodeString(String str) {
    sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
    return new String(encoder.encodeBuffer(str.getBytes())).trim();
    }
     */
    /**
     * Decode a string using Base64 encoding.
     *
     * @param str
     *            String to be decoded
     * @return String decoding String

    public static String decodeString(String str) {
    sun.misc.BASE64Decoder dec = new sun.misc.BASE64Decoder();
    try {
    return new String(dec.decodeBuffer(str));
    } catch (IOException io) {
    throw new RuntimeException(io.getMessage(), io.getCause());
    }
    }
     */
    /**
     * convert first letter to a big letter or a small letter.<br>
     *
     * <pre>
     * StringUtil.trim('Password') = 'password'
     * StringUtil.trim('password') = 'Password'
     * </pre>
     *
     * @param str
     *            String to be swapped
     * @return String converting result
     */
    public static String swapFirstLetterCase(String str) {
        StringBuffer sbuf = new StringBuffer(str);
        sbuf.deleteCharAt(0);
        if (Character.isLowerCase(str.substring(0, 1).toCharArray()[0])) {
            sbuf.insert(0, str.substring(0, 1).toUpperCase());
        } else {
            sbuf.insert(0, str.substring(0, 1).toLowerCase());
        }
        return sbuf.toString();
    }

    /**
     * If original String has a specific String, remove specific Strings from original String.
     *
     * <pre>
     * StringUtil.trim('pass*word', '*') = 'password'
     * </pre>
     *
     * @param origString
     *            original String
     * @param trimString
     *            String to be trimmed
     * @return converting result
     */
    public static String trim(String origString, String trimString) {
        int startPosit = origString.indexOf(trimString);
        if (startPosit != -1) {
            int endPosit = trimString.length() + startPosit;
            return origString.substring(0, startPosit) + origString.substring(endPosit);
        }
        return origString;
    }

    /**
     * Break a string into specific tokens and return a String of last location.
     *
     * <pre>
     * StringUtil.getLastString('password*password*a*b*c', '*') = 'c'
     * </pre>
     *
     * @param origStr
     *            original String
     * @param strToken
     *            specific tokens
     * @return String of last location
     */
    public static String getLastString(String origStr, String strToken) {
        StringTokenizer str = new StringTokenizer(origStr, strToken);
        String lastStr = "";
        while (str.hasMoreTokens()) {
            lastStr = str.nextToken();
        }
        return lastStr;
    }

    /**
     * If original String has token, Break a string into specific tokens and change String Array. If not, return a String Array which has
     * original String as it is.
     *
     * <pre>
     * StringUtil.getStringArray('passwordabcpassword', 'abc') 		= String[]{'password','password'}
     * StringUtil.getStringArray('pasword*password', 'abc') 		= String[]{'pasword*password'}
     * </pre>
     *
     * @param str
     *            original String
     * @param strToken
     *            specific String token
     * @return String[]
     */
    public static String[] getStringArray(String str, String strToken) {
        if (str.indexOf(strToken) != -1) {
            StringTokenizer st = new StringTokenizer(str, strToken);
            String[] stringArray = new String[st.countTokens()];
            for (int i = 0; st.hasMoreTokens(); i++) {
                stringArray[i] = st.nextToken();
            }
            return stringArray;
        }
        return new String[] { str };
    }

    /**
     * If string is null or empty string, return false. <br>
     * If not, return true.
     *
     * <pre>
     * StringUtil.isNotEmpty('') 		= false
     * StringUtil.isNotEmpty(null) 		= false
     * StringUtil.isNotEmpty('abc') 	= true
     * </pre>
     *
     * @param str
     *            original String
     * @return which empty string or not.
     */
    public static boolean isNotEmpty(String str) {
        return !isEmptyTrimmed(str);
    }

    /**
     * If string is null or empty string, return true. <br>
     * If not, return false.
     *
     * <pre>
     * StringUtil.isEmpty('') 		= true
     * StringUtil.isEmpty(null) 	= true
     * StringUtil.isEmpty('abc') 	= false
     * </pre>
     *
     * @param str
     *            original String
     * @return which empty string or not.
     */
    public static boolean isEmpty(String str) {
        return (str == null || str.length() == 0);
    }

    /**
     * replace replaced string to specific string from original string. <br>
     *
     * <pre>
     * StringUtil.replace('work$id', '$', '.') 	= 'work.id'
     * </pre>
     *
     * @param str
     *            original String
     * @param replacedStr
     *            to be replaced String
     * @param replaceStr
     *            replace String
     * @return converting result
     */
    public static String replace(String str, String replacedStr, String replaceStr) {
        String newStr = "";
        if (str.indexOf(replacedStr) != -1) {
            String s1 = str.substring(0, str.indexOf(replacedStr));
            String s2 = str.substring(str.indexOf(replacedStr) + 1);
            newStr = s1 + replaceStr + s2;
        }
        return newStr;
    }

    /**
     * It converts the string representation of a number to integer type (eg. '27' -> 27)
     *
     * <pre>
     * StringUtil.string2integer('14') 	= 14
     * </pre>
     *
     * @param str
     *            string representation of a number
     * @return integer integer type of string
     */
    public static int string2integer(String str) {
        int ret = Integer.parseInt(str.trim());

        return ret;
    }

    /**
     * It converts integer type to String ( 27 -> '27')
     *
     * <pre>
     * StringUtil.integer2string(14) 	= '14'
     * </pre>
     *
     * @param integer
     *            integer type
     * @return String string representation of a number
     */
    public static String integer2string(int integer) {
        return ("" + integer);
    }

    /**
     * It returns true if str matches the pattern string. It performs regular expression pattern matching.
     *
     * <pre>
     * StringUtil.isPatternMatching('abc-def', '*-*') 	= true
     * StringUtil.isPatternMatching('abc', '*-*') 	= false
     * </pre>
     *
     * @param str
     *            original String
     * @param pattern
     *            pattern String
     * @return boolean which matches the pattern string or not.
     * @throws Exception
     *             fail to check pattern matched
     */
    public static boolean isPatternMatching(String str, String pattern) throws Exception {
        // if url has wild key, i.e. "*", convert it to ".*" so that we can
        // perform regex matching
        if (pattern.indexOf('*') >= 0) {
            pattern = pattern.replaceAll("\\*", ".*");
        }

        pattern = "^" + pattern + "$";

        return Pattern.matches(pattern, str);
    }

    /**
     * It returns true if string contains a sequence of the same character.
     *
     * <pre>
     * StringUtil.containsMaxSequence('password', '2') 	= true
     * StringUtil.containsMaxSequence('my000', '3') 	= true
     * StringUtil.containsMaxSequence('abbbbc', '5')	= false
     * </pre>
     *
     * @param str
     *            original String
     * @param maxSeqNumber
     *            a sequence of the same character
     * @return which contains a sequence of the same character
     */
    public static boolean containsMaxSequence(String str, String maxSeqNumber) {
        int occurence = 1;
        int max = string2integer(maxSeqNumber);
        if (str == null) {
            return false;
        }

        int sz = str.length();
        for (int i = 0; i < (sz - 1); i++) {
            if (str.charAt(i) == str.charAt(i + 1)) {
                occurence++;

                if (occurence == max)
                    return true;
            } else {
                occurence = 1;
            }
        }
        return false;
    }

    /**
     * <p>
     * Checks that the String contains certain characters.
     * </p>
     * <p>
     * A <code>null</code> String will return <code>false</code>. A <code>null</code> invalid character array will return <code>false</code>
     * . An empty String ("") always returns false.
     * </p>
     *
     * <pre>
     * StringUtil.containsInvalidChars(null, *)       			= false
     * StringUtil.containsInvalidChars(*, null)      			= false
     * StringUtil.containsInvalidChars(&quot;&quot;, *)         = false
     * StringUtil.containsInvalidChars(&quot;ab&quot;, '')      = false
     * StringUtil.containsInvalidChars(&quot;abab&quot;, 'xyz') = false
     * StringUtil.containsInvalidChars(&quot;ab1&quot;, 'xyz')  = false
     * StringUtil.containsInvalidChars(&quot;xbz&quot;, 'xyz')  = true
     * </pre>
     *
     * @param str
     *            the String to check, may be null
     * @param invalidChars
     *            an array of invalid chars, may be null
     * @return false if it contains none of the invalid chars, or is null
     */

    public static boolean containsInvalidChars(String str, char[] invalidChars) {
        if (str == null || invalidChars == null) {
            return false;
        }
        int strSize = str.length();
        int validSize = invalidChars.length;
        for (int i = 0; i < strSize; i++) {
            char ch = str.charAt(i);
            for (int j = 0; j < validSize; j++) {
                if (invalidChars[j] == ch) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * <p>
     * Checks that the String contains certain characters.
     * </p>
     * <p>
     * A <code>null</code> String will return <code>false</code>. A <code>null</code> invalid character array will return <code>false</code>
     * . An empty String ("") always returns false.
     * </p>
     *
     * <pre>
     * StringUtil.containsInvalidChars(null, *)       			= false
     * StringUtil.containsInvalidChars(*, null)      			= false
     * StringUtil.containsInvalidChars(&quot;&quot;, *)         = false
     * StringUtil.containsInvalidChars(&quot;ab&quot;, '')      = false
     * StringUtil.containsInvalidChars(&quot;abab&quot;, 'xyz') = false
     * StringUtil.containsInvalidChars(&quot;ab1&quot;, 'xyz')  = false
     * StringUtil.containsInvalidChars(&quot;xbz&quot;, 'xyz')  = true
     * </pre>
     *
     * @param str
     *            the String to check, may be null
     * @param invalidChars
     *            a String of invalid chars, may be null
     * @return false if it contains none of the invalid chars, or is null
     */
    public static boolean containsInvalidChars(String str, String invalidChars) {
        if (str == null || invalidChars == null) {
            return true;
        }
        return containsInvalidChars(str, invalidChars.toCharArray());
    }

    /**
     * <p>
     * Checks if the String contains only unicode letters or digits.
     * </p>
     * <p>
     * <code>null</code> will return <code>false</code>. An empty String ("") will return <code>false</code>.
     * </p>
     *
     * <pre>
     * StringUtil.isAlphaNumeric(null)   			 = false
     * StringUtil.isAlphaNumeric(&quot;&quot;)     = false
     * StringUtil.isAlphaNumeric(&quot;  &quot;)   = false
     * StringUtil.isAlphaNumeric(&quot;abc&quot;)  = true
     * StringUtil.isAlphaNumeric(&quot;ab c&quot;) = false
     * StringUtil.isAlphaNumeric(&quot;ab2c&quot;) = true
     * StringUtil.isAlphaNumeric(&quot;ab-c&quot;) = false
     * </pre>
     *
     * @param str
     *            the String to check, may be null
     * @return <code>true</code> if only contains letters or digits, and is non-null
     */
    public static boolean isAlphaNumeric(String str) {
        if (str == null) {
            return false;
        }
        int sz = str.length();
        if (sz == 0)
            return false;
        for (int i = 0; i < sz; i++) {
            if (!Character.isLetterOrDigit(str.charAt(i))) {
                return false;
            }
        }
        return true;
    }

    /**
     * <p>
     * Checks if the String contains only unicode letters.
     * </p>
     * <p>
     * <code>null</code> will return <code>false</code>. An empty String ("") will return <code>false</code>.
     * </p>
     *
     * <pre>
     * StringUtil.isAlpha(null)   			= false
     * StringUtil.isAlpha(&quot;&quot;)     = false
     * StringUtil.isAlpha(&quot;  &quot;)   = false
     * StringUtil.isAlpha(&quot;abc&quot;)  = true
     * StringUtil.isAlpha(&quot;ab2c&quot;) = false
     * StringUtil.isAlpha(&quot;ab-c&quot;) = false
     * </pre>
     *
     * @param str
     *            the String to check, may be null
     * @return <code>true</code> if only contains letters, and is non-null
     */
    public static boolean isAlpha(String str) {
        if (str == null) {
            return false;
        }
        int sz = str.length();
        if (sz == 0)
            return false;
        for (int i = 0; i < sz; i++) {
            if (!Character.isLetter(str.charAt(i))) {
                return false;
            }
        }
        return true;
    }

    /**
     * <p>
     * Checks if the String contains only unicode digits. A decimal point is not a unicode digit and returns false.
     * </p>
     * <p>
     * <code>null</code> will return <code>false</code>. An empty String ("") will return <code>false</code>.
     * </p>
     *
     * <pre>
     * StringUtil.isNumeric(null)   		   = false
     * StringUtil.isNumeric(&quot;&quot;)     = false
     * StringUtil.isNumeric(&quot;  &quot;)   = false
     * StringUtil.isNumeric(&quot;123&quot;)  = true
     * StringUtil.isNumeric(&quot;12 3&quot;) = false
     * StringUtil.isNumeric(&quot;ab2c&quot;) = false
     * StringUtil.isNumeric(&quot;12-3&quot;) = false
     * StringUtil.isNumeric(&quot;12.3&quot;) = false
     * </pre>
     *
     * @param str
     *            the String to check, may be null
     * @return <code>true</code> if only contains digits, and is non-null
     */
    public static boolean isNumeric(String str) {
        if (str == null) {
            return false;
        }
        int sz = str.length();
        if (sz == 0)
            return false;
        for (int i = 0; i < sz; i++) {
            if (!Character.isDigit(str.charAt(i))) {
                return false;
            }
        }
        return true;
    }

    /**
     * <p>
     * Checks if the String contains only unicode digits. A decimal point is not a unicode digit and returns false.
     * </p>
     * <p>
     * <code>null</code> will return <code>false</code>. An empty String ("") will return <code>false</code>.
     * </p>
     *
     * <pre>
     * StringUtil.isNumeric(null)              = false
     * StringUtil.isNumeric(&quot;&quot;)     = false
     * StringUtil.isNumeric(&quot;  &quot;)   = false
     * StringUtil.isNumeric(&quot;123&quot;)  = true
     * StringUtil.isNumeric(&quot;12 3&quot;) = false
     * StringUtil.isNumeric(&quot;ab2c&quot;) = false
     * StringUtil.isNumeric(&quot;12-3&quot;) = false
     * StringUtil.isNumeric(&quot;12.3&quot;) = false
     * </pre>
     *
     * @param str
     *            the String to check, may be null
     * @return <code>true</code> if only contains digits, and is non-null
     */
    public static boolean isNumericDecimal(String str) {
        if (str == null) {
            return false;
        }
        int sz = str.length();
        if (sz == 0)
            return false;
        for (int i = 0; i < sz; i++) {
            if (!Character.isDigit(str.charAt(i)) && !DOT.equals(Character.toString(str.charAt(i)))) {
                return false;
            }
        }
        return true;
    }

    /**
     * <p>
     * Reverses a String as per {@link StringBuffer#reverse()}.
     * </p>
     * <p>
     * <A code>null</code> String returns <code>null</code>.
     * </p>
     *
     * <pre>
     * StringUtil.reverse(null)  		   = null
     * StringUtil.reverse(&quot;&quot;)    = &quot;&quot;
     * StringUtil.reverse(&quot;bat&quot;) = &quot;tab&quot;
     * </pre>
     *
     * @param str
     *            the String to reverse, may be null
     * @return the reversed String, <code>null</code> if null String input
     */

    public static String reverse(String str) {
        if (str == null) {
            return null;
        }
        return new StringBuffer(str).reverse().toString();
    }

    /**
     * Make a new String that filled original to a special char as cipers
     *
     * @param originalStr
     *            original String
     * @param ch
     *            a special char
     * @param cipers
     *            cipers
     * @return filled String
     */
    public static String fillString(String originalStr, char ch, int cipers) {
        int originalStrLength = originalStr.length();

        if (cipers < originalStrLength)
            return null;

        int difference = cipers - originalStrLength;

        StringBuffer strBuf = new StringBuffer();
        for (int i = 0; i < difference; i++)
            strBuf.append(ch);

        strBuf.append(originalStr);
        return strBuf.toString();
    }

    /**
     * Determine whether a (trimmed) string is empty
     *
     * @param foo
     *            The text to check.
     * @return Whether empty.
     */
    public static final boolean isEmptyTrimmed(String foo) {
        return (foo == null || foo.trim().length() == 0);
    }

    /**
     * Return token list
     *
     * @param lst
     * @param separator
     * @return token list
     */
    public static List<String> getTokens(String lst, String separator) {
        List<String> tokens = new ArrayList<String>();

        if (lst != null) {
            StringTokenizer st = new StringTokenizer(lst, separator);
            while (st.hasMoreTokens()) {
                try {
                    String en = st.nextToken().trim();
                    tokens.add(en);
                } catch (Exception e) {
                    log.error("String tokening error occurs. Error : " + e.getMessage());
                }
            }
        }

        return tokens;
    }

    /**
     * Return token list which is separated by ","
     *
     * @param lst
     * @return token list which is separated by ","
     */
    public static List<String> getTokens(String lst) {
        return getTokens(lst, ",");
    }

    /**
     * This method convert "string_util" to "stringUtil"
     *
     * @param targetString
     *
     * @param posChar
     *
     * @return convert "string_util" to "stringUtil"
     */
    public static String convertToCamelCase(String targetString, char posChar) {
        StringBuffer result = new StringBuffer();
        boolean nextUpper = false;
        String allLower = targetString.toLowerCase();

        for (int i = 0; i < allLower.length(); i++) {
            char currentChar = allLower.charAt(i);
            if (currentChar == posChar) {
                nextUpper = true;
            } else {
                if (nextUpper) {
                    currentChar = Character.toUpperCase(currentChar);
                    nextUpper = false;
                }
                result.append(currentChar);
            }
        }
        return result.toString();
    }

    /**
     * Convert a string that may contain underscores to camel case.
     *
     * @param underScore
     *            Underscore name.
     * @return Camel case representation of the underscore string.
     */
    public static String convertToCamelCase(String underScore) {
        return convertToCamelCase(underScore, '_');
    }

    /**
     * Convert a camel case string to underscore representation.
     *
     * @param camelCase
     *            Camel case name.
     * @return Underscore representation of the camel case string.
     */
    public static String convertToUnderScore(String camelCase) {
        String result = "";
        for (int i = 0; i < camelCase.length(); i++) {
            char currentChar = camelCase.charAt(i);
            // This is starting at 1 so the result does not end up with an
            // underscore at the begin of the value
            if (i > 0 && Character.isUpperCase(currentChar)) {
                result = result.concat("_");
            }
            result = result.concat(Character.toString(currentChar).toLowerCase());
        }
        return result;
    }

    /**
     * Trim the original string. If the original string is null or string length size is zero, return the converted string.
     *
     * @param org
     *            original string
     * @param converted
     *            converted string
     * @return trimmed string
     */
    public static String null2str(String org, String converted) {
        if (org == null || org.trim().length() == 0) {
            return converted;
        }
        return org.trim();
    }

    /**
     * Trim the original string. If the original string is null or string length size is zero, return the empty string.
     *
     * @param org
     *            original string
     * @return trimmed string
     */
    public static String null2str(String org) {
        return StringUtil.null2str(org, "");
    }

    public static String nullObj2str(Object org) {
        return org == null ? "" : org.toString();
    }

    public static String greaterThan2Convert(String org, String base, String converted) {
        if (!StringUtil.isNumeric(org) || !StringUtil.isNumeric(base)) {
            return converted;
        }
        if (StringUtil.string2integer(org) > StringUtil.string2integer(base)) {
            return converted;
        }
        return org.trim();
    }

    public static String lpad(String org, int length, char pad) {
        char [] array;
        if (org == null || org.trim().length() == 0) {
            array = new char[length];
            Arrays.fill(array, pad);
            return String.valueOf(array);
        }
        if (!isNumeric(org) || org.length() >= length) {
            array = new char[length];
            Arrays.fill(array, pad);
            return String.valueOf(array) + org;
        }
        array = new char[length - org.length()];
        Arrays.fill(array, pad);
        return String.valueOf(array) + org;
    }

    public static String convertXSS(String value) {
        if (value == null || value.trim().equals("")) {
            return "";
        }

        String returnValue = value;

        returnValue = returnValue.replaceAll("&quot;", "\"");
        returnValue = returnValue.replaceAll("&lt;", "<");
        returnValue = returnValue.replaceAll("&gt;", ">");
        returnValue = returnValue.replaceAll("&amp;;", "&");
//		returnValue = returnValue.replaceAll("\"", "&#34;");
//		returnValue = returnValue.replaceAll("\'", "&#39;");
//		returnValue = returnValue.replaceAll(".", "&#46;");
//		returnValue = returnValue.replaceAll("%2E", "&#46;");
//		returnValue = returnValue.replaceAll("%2F", "&#47;");

        return returnValue;
    }

    public static boolean isToday(String str) throws ParseException {
        Date currentDate;
        Date compareDate;
        String oTime = "";

        SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date currentTime = new Date();
        oTime = mSimpleDateFormat.format(currentTime);

        compareDate = mSimpleDateFormat.parse(str);
        currentDate = mSimpleDateFormat.parse(oTime);

        int compare = currentDate.compareTo(compareDate);

        if(compare == 0) {
            return true;
        } else {
            return false;
        }
    }

    public static String replaceAllIgnoreCase(String text, String search, String replacement){
        if(search.equals(replacement)){
            return text;
        }

        StringBuffer buffer = new StringBuffer(text);
        String lowerSearch = search.toLowerCase(Locale.ENGLISH);
        int i=0;
        for(int prev=0; (i=buffer.toString().toLowerCase(Locale.ENGLISH).indexOf(lowerSearch, prev)) > -1; prev=1+replacement.length()){
            buffer.replace(i, i+search.length(), replacement);
        }

        return buffer.toString();
    }


    public static String getSecureName(String name) {
        if (name == null || name.length() == 0) {
            return null;
        }

        String secureName = name.substring(0, 1);
        for (int i = 1; i < name.length(); i++) {
            secureName += "*";
        }

        return secureName;
    }

}

