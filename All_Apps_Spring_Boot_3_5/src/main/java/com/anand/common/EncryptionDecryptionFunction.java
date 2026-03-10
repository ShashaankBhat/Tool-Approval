/**
 * *******************************************************************************************
 * Copyright © 2021 Anand Group India. All rights reserved.
 * No part of this product may be reproduced in any form by any means without prior
 * written authorization of Anand Automotive Private Limited and its licensors, if any.
 * *******************************************************************************************
 * Author - Sheshadhri Iyer
 */
package com.anand.common;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Hex;
/**
 * Implementation for encryption and decryption of data
 * @author Sheshadhri.Iyer
 */
public abstract class EncryptionDecryptionFunction {

	/** Binary EnCoder/Decoder Object */
	private static Hex hex = new Hex();

	/** 16-bit Key */
	//private static String defaultKey = "@!#$%^&*()_+1234";
	private static String defaultKey = "@!#$%^AnAnD+1234";

	/*                                      Encryption Function                                     */
	/* ******************************************************************************************** */
	/**
	 * Pass a plain text and get encrypted data as response
	 * Sheshadhri.Iyer
	 */
	public static String getEncryptedData(String plainText) throws Exception  {
		return byte2Hex(encrypt( plainText.getBytes(),defaultKey.getBytes("UTF-8")));
	}

	/**
	 * Encrypt the byte format text with respect to the byte format key string
	 * Returns encrypted byte format
	 * Sheshadhri.Iyer
	 */
	public static byte[] encrypt(byte[] plainText, byte[] key) {
		try {
			SecretKeySpec skeySpec = new SecretKeySpec(key, "AES");
			Cipher cipher = Cipher.getInstance("AES");
			cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
			byte[] decryptText = cipher.doFinal(plainText);
			return decryptText;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * Encode byte to String format
	 * Converts an array of bytes into an array of bytes for the characters representing the 
	 * hexadecimal values of each byte in order.
	 * Sheshadhri.Iyer
	 */
	private static String byte2Hex(byte[] b) {
		return new String(hex.encode(b));
	}
	/* ******************************************************************************************** */

	/*                                     Decryption Function                                      */
	/* ******************************************************************************************** */
	/**
	 * Pass a encrypted string and get decrypted data as response
	 * Sheshadhri.Iyer
	 */
	public static String getDecryptedData(String cipherText) throws Exception {
		return new String(decrypt( hex2Byte(cipherText), defaultKey.getBytes("UTF-8")));
	}

	/**
	 * Decode String to byte format
	 * Converts an array of character bytes representing hexadecimal values into an array of bytes of those same values.
	 * Sheshadhri.Iyer
	 */
	private static byte[] hex2Byte(String b) throws Exception {
		return hex.decode(b.getBytes());
	}

	/**
	 * Decrypt the byte format text with respect to the byte format key string
	 * Sheshadhri.Iyer
	 */
	public static byte[] decrypt(byte[] cipherText, byte[] key) {
		try {
			SecretKeySpec skeySpec = new SecretKeySpec(key, "AES");
			Cipher cipher = Cipher.getInstance(	"AES");
			cipher.init(Cipher.DECRYPT_MODE, skeySpec);
			byte[] plainText = cipher.doFinal(cipherText);
			return plainText;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
