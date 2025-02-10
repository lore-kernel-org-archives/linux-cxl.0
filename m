Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA2E18BB8E
	for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739169884; cv=pass; b=QE/SoSTXWPOCEX1c5nCMhLC2QDAO8n5DeU4tmPxZdWQQZc1bdaQj31aE5TUDgmd/KSKQc3T2eFqcluh0fJ4JGv7unqnKBqAqsEfdcZ2GjvjHVYSTqIfpCY69ZLPfvQLStCDwlqlBNntmwGNAaqSMlNtVAd0jWpEywVszq65ShkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739169884; c=relaxed/simple;
	bh=mTuTzQU4LNB1VQSTd2oDmSjHSVYmz9TRbCW0zJStB+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhvrjrPEFEzetUjEA1hhfBkOnqni5xtTz89OGJtgyuQU2Ecp/9yJvAOf4hNDsQq+/QVC1+9vBm/Ti+2PEevXBd2Ty3VFHx9c/Hucf0lyfdnoMDVyxqcybJzFLBM/+TVcaIed785EgDTHsOO9GauWsgMsOpC8ttgo/wa77yAtRzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=YTbkSAqj; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="YTbkSAqj"
ARC-Seal: i=1; a=rsa-sha256; t=1739169864; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kuqKl693DEtK7t2zka7Bpsni4qxRblVC6OODGOA0N7kayvEFfOhakmxL6sJokES0lKllyFPa9PsCIOYYX5/GCIKnBGhool7IrNgT5esxkzJmwaIwm41S9qaN7yWP+fPsCikqyN79ekbtiOLQRY20VfsWYAx7gICMGEMePrIqd0c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739169864; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mTuTzQU4LNB1VQSTd2oDmSjHSVYmz9TRbCW0zJStB+A=; 
	b=Sldf/bvzfb1k2PBMd7Wio+PJQt4oDe0cuMHjxouuvWTGmuPFMHe7c/sAnc4emOVf5Lmny0CUrnhNTn6istaJD2fKB2kwCnbTRjFLn1+8s3ncOhBFcYxwbGA8KZayhBu0bgvlSFOtieJAuc7xMPuQ1lUsNhZzlLIT1+8XeG2KJuQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739169864;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=mTuTzQU4LNB1VQSTd2oDmSjHSVYmz9TRbCW0zJStB+A=;
	b=YTbkSAqjwSZ+4uCLbXYf7FuYqiW9yr0BS7ox9teoBzNM37JLWJuToAZ+8tOHUli8
	+pabsHh4WKmwYjy9Jr5rxvl9VJoD2h6f2RN/fxl/WV2a4Ed/57Xdkze6MMhU6XD0ddj
	0SA09c8LEM6XzD5mGbF5CMW/iyVEjSKtvIL75jrA=
Received: by mx.zohomail.com with SMTPS id 173916986190933.42736584056024;
	Sun, 9 Feb 2025 22:44:21 -0800 (PST)
Message-ID: <be158598-59b7-4e0c-8c4b-a0fe3381b8f3@zohomail.com>
Date: Mon, 10 Feb 2025 14:44:18 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] cxl/test: Add Get Feature support to cxl_test
To: Dave Jiang <dave.jiang@intel.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com, linux-cxl@vger.kernel.org
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-14-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250207233914.2375110-14-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227b9c025aae4d99a7ce92ebc1700002bc17fea04728a20608e9ed77fc2a331b897ba82c30a1f3f7f:zu08011227e31fd1c9dfbd7a41b0baa7960000df6b42497623392ebcb3a8861abd1ca14ff97ff58aa5033fb2:rf0801122d287b6b597668e8cd37c53f58000043ec234dcee38967a2df4e5c6420b5a7f6077885b50b8c68881f238f4cf318:ZohoMail
X-ZohoMailClient: External

On 2/8/2025 7:37 AM, Dave Jiang wrote:
> Add emulation of Get Feature command to cxl_test. The feature for
> device patrol scrub is returned by the emulation code. This is
> the only feature currently supported by cxl_test. It returns
> the information for the device patrol scrub feature.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Li Ming <ming.li@zohomail.com>

