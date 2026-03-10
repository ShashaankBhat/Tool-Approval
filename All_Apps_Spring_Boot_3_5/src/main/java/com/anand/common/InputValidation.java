package com.anand.common;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Service;

@Service
public class InputValidation {

	public Boolean onlyAlpabetCheckWithSpace(String inputString) {
		String regex = "^[a-zA-Z-Á ]*$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(inputString);
		if(matcher.matches()) {
			matcher = null; pattern = null; regex = null;
			return true;
		} else {
			matcher = null; pattern = null; regex = null;
			return false;
		}
	}

	public Boolean stringOnlyValidation(String inputString) {
		String regex = "^[a-zA-Z-Á&\\s]*$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(inputString);
		if(matcher.matches()) {
			matcher = null; pattern = null; regex = null;
			return true;
		} else {
			matcher = null; pattern = null; regex = null;
			return false;
		}
	}

	public Boolean numberOnlyValidation(String inputString) {
		String regex = "^[0-9]*$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(inputString);
		if(matcher.matches()) {
			matcher = null; pattern = null; regex = null;
			return true;
		} else {
			matcher = null; pattern = null; regex = null;
			return false;
		}
	}

	public Boolean decimalNumberCheck(String inputString) {
		String regex = "[+-]?([0-9]*[.])?[0-9]+";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(inputString);
		if(matcher.matches()) {
			matcher = null; pattern = null; regex = null;
			return true;
		} else {
			matcher = null; pattern = null; regex = null;
			return false;
		}
	}

	public Boolean alphaNumericValidationWithoutSpace(String inputString) {
		String regex = "^[a-zA-Z0-9&-Á]*$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(inputString);
		if(matcher.matches()) {
			matcher = null; pattern = null; regex = null;
			return true;
		} else {
			matcher = null; pattern = null; regex = null;
			return false;
		}
	}

	public Boolean alphaNumericValidationWithSpace(String inputString) {
		String regex = "^[a-zA-Z0-9&-Á ]*$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(inputString);
		if(matcher.matches()) {
			matcher = null; pattern = null; regex = null;
			return true;
		} else {
			matcher = null; pattern = null; regex = null;
			return false;
		}
	}

	public Boolean textareaValidation(String inputString) {
		String regex = "^[ A-Za-z0-9.\r\n;:\"',-/]*$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(inputString);
		if(matcher.matches()) {
			matcher = null; pattern = null; regex = null;
			return true;
		} else {
			matcher = null; pattern = null; regex = null;
			return false;
		}
	}

	public Boolean textareaValidationForCheckSheet(String inputString) {
		String regex = "^[ A-Za-z0-9.\r\n;:\"',+-/]*$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(inputString);
		if(matcher.matches()) {
			matcher = null; pattern = null; regex = null;
			return true;
		} else {
			matcher = null; pattern = null; regex = null;
			return false;
		}
	}

	public Boolean inputStringWithMinimalSpecialCharacterValidation(String inputString) {
		String regex = "^[ A-Za-z0-9.\r\n;:\"',-/]*$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(inputString);
		if(matcher.matches()) {
			matcher = null; pattern = null; regex = null;
			return true;
		} else {
			matcher = null; pattern = null; regex = null;
			return false;
		}
	}

	public Boolean emailIdValidation(String inputString) {
		String regex = "^(.+)@(.+)$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(inputString);
		if(matcher.matches()) {
			matcher = null; pattern = null; regex = null;
			return true;
		} else {
			matcher = null; pattern = null; regex = null;
			return false;
		}
	}

	public Boolean urlValidation(String inputString) {
		String regex = "((http|https)://)(www.)?[a-zA-Z0-9@:%._\\+~#?&//=]{2,256}\\.[a-z]{2,6}\\b([-a-zA-Z0-9@:%._\\+~#?&//=]*)";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(inputString);
		if(matcher.matches()) {
			matcher = null; pattern = null; regex = null;
			return true;
		} else {
			matcher = null; pattern = null; regex = null;
			return false;
		}
	}
}
