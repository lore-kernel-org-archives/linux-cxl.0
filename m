Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8266376F1
	for <linux-cxl@vger.kernel.org>; Fri,  9 May 2025 00:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746752160; cv=pass; b=h45eP9ZOyWuQ6f8RR5N7zIjMNrK+7DBP5l8AjVy7zzEzAWYeGgAepzTGkuYshtAuWDGDpx1A7DqfHq0fO+BTegp6sAS3+NJdGhnytdB8PBa553eVgisxC37c7qFo5PhEKv+aLyYAZhJ4km1LpFydhzOOTJOpNqd33cqA/Y5VcZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746752160; c=relaxed/simple;
	bh=vNmIDHSeQdgTt2ADHksQnt/mPBCfi5zxz0TRwqaBwls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UclD07azC6HqUWXo72ILi9tjCLU1JjvYXYGdR31SdyQKgtTAUBc9PZ5KoCXJ5FgfwCBwXQ1EpfU9RyThwLqXTDkz3DNgIStms35w8U3Dl9wKNsuAXVQjqUWU50DJJLLhUSJMoztGmVY1NbaUoh1mGcVy1Qg9UC+rauUIAGRqc24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=WEXGs8jH; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="WEXGs8jH"
ARC-Seal: i=1; a=rsa-sha256; t=1746752144; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TAdh01mNjHDOwCEfeN1B9K37plqS3/YXKA6nDlP+ct+NhrZ2oDrzPu7fanE1sZmqkLeghtmx5/8uRojzkltDVAvkhmx44FLftqGM5NL+7Cj13x+9S+ceVWtKZNMnRiRyrzePuHSnuXbmySaNd9F77wWnmoUTKp5bRPqiIbeniTY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746752144; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vNmIDHSeQdgTt2ADHksQnt/mPBCfi5zxz0TRwqaBwls=; 
	b=D5ALvLSrUdrTU3GLGNHrpTh10o+5Xj7B9/5aZcLTrWKVhehFGTIhPjo9McYsoDjsOB9LFxxDndl7vkFGlXNbo5J0Tg9rNiclVNNJGrDSsW+y78fNcWzMglGImJgI/pPLjwbHksD6fhfJwHW3qikcoDXvW7/e0AYScWhcrbL6RyU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746752143;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=vNmIDHSeQdgTt2ADHksQnt/mPBCfi5zxz0TRwqaBwls=;
	b=WEXGs8jHdR1us3HQ1ahJVNePo2VBBR5yHJARxBNRyunaba6GC/wVlfaQBkYgSm6P
	zL1bcrwCnmOFYd9AsDFI9Gn3soYwEaoMPYjn4VjJO5wbTOJMW160o5VrCGb1RXalDCR
	iHw28Q1VNwoDXNmRzzokOkQxTDImqUsQjrOkS/ak=
Received: by mx.zohomail.com with SMTPS id 1746752141076104.86091483784628;
	Thu, 8 May 2025 17:55:41 -0700 (PDT)
Message-ID: <181d0ea8-a9fa-42aa-994d-8981e132dea2@zohomail.com>
Date: Fri, 9 May 2025 08:55:37 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] cxl: Rename find_dport() to provide better
 function intent
To: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, rrichter@amd.com, linux-cxl@vger.kernel.org
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-4-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250507004310.3536991-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227ce8815a5a61e8a06101710ee0000476eb15d27567c0e507469350aa72a51792a0434aa0775b153:zu080112274d286052a4f1a4152af26d560000fb94c61aefba30066a0d26c5f2c16e00938b92370b608e28c6:rf0801122ddf6bbba6f92bbc4ccb19603a0000b29d4d15e38b0443ecd48c2cf61cbb6b1976850f6b3bc8d0f05a52e5ea3a62:ZohoMail
X-ZohoMailClient: External

On 5/7/2025 8:43 AM, Dave Jiang wrote:
> Rename find_dport() to find_dport_by_num() to indicate that the function
> is trying to match a dport by its hardware number index.
>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
