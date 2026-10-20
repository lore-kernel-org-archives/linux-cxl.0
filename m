Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792500667;
	b=wKvf2xrSR+b4ZGPNDu/2XwvnvRK7Lj++iL6ygGyraxCzvXiPKv0bdq8IaglJ5G/N5bjz
	 4vYGBSyFYugPWqaIxJyE8BFCCwtgvSQLuqGowObThaWLwaDy5svyvKCY2HEq6K/SsV827
	 D9GPQvTWzy8IgdC3GtTjCpJeufAbFeL00ozE/Vp7NbgdN17WJRiwRomZym69ThSqlsDBt
	 9pL0xDYhcrhs+eDzGns0td/YKvQBvZjy+xscCpN6Lfi5NkzPpo8ldACLH5OpQBX328veq
	 osw6ghqTLx4+CHctUzoTKDeqbbpbgTwZqGg6uWwh8bcuaes7l+DcsWvzNYiM/cRgrvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500667;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=eJspOywmDZU5gaFFE99FEqN+qI+6DucLAWXc2IOUlV8=;
	b=I+E2o8s+GCyvHa5L/or4CTbzNerim6nlu3OQLM1FmmS4JWyKSidVLiwfVxvQpm6r0B+i
	 6WGMHyhzL7yblaXWJgjgz9/13NiksyHX0pzWpGNc94xVDwPpAAenJt2Ngabn43RhOzd6S
	 vngP9pchMtCuZqU5KGSV6tHMiZnKkf2OsUGuT/KGI2OJ9qxAOU4Yqac1cywy6/akCs8i5
	 l9Np76JQibz+vOSLFeTCF0T8gMu/nXYZtuJ1erXWEhGNLpqsYNYXiTI0/4G5AbFgZzsQf
	 oFZlFz/7pfua43N9/RBiHm76S0UGSN+8BwYWYZX/j7BYxnCtkyfp/B9wDwBqnkwS3nQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=Jk85CJzW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53DD606A319;
	Tue, 20 Oct 2026 12:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E53DD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=Jk85CJzW
ARC-Seal: i=1; a=rsa-sha256; t=1792500658; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=A7NB2iQVQe25QLZRxYuqK4Z3HrEOaMBhiJ4tZiH5nUh+apdVZ9JaZ4u7B4LrzAmSEeV7K66g3mqNvKIpg4d5BS10UZkR41ppjj3OtTV+IBgaiVDLtOHVE14Pwd6vrzmnzTfgU0z7Sp/E4qc+hHWdhyVQUDpylDt8S9NQ1YHcojo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792500658; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eJspOywmDZU5gaFFE99FEqN+qI+6DucLAWXc2IOUlV8=; 
	b=WSIpHQpM4MzQQDSGEHxxRiBEIICWqya5ypGW1jYaYhffQ4FOmDeB2weob2Pq5pdhdRSNwGC1+41eXWwaIp/ccYZjfyWC8Xkxsh1S6Wy5q9hP0QzWMyYLyi/jn9OTkkDgk69sb1MgNZhhHfmOqtIi5M6PTJqCRRywfFwlAEOg2ho=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792500658;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=eJspOywmDZU5gaFFE99FEqN+qI+6DucLAWXc2IOUlV8=;
	b=Jk85CJzW49Hga94txNBJswWv//PDKgrjZGJZQ14EcqVPbpoaJ2aWap6sVkxT5Get
	a5d9BmCgb6WqsOhCrTf2r+LJpYreYcSX605cj0tksOPQAPN0TSefUk9U0gzWydoxfMb
	3IVXvGlqdPhtRYUY2X6XqbopQ4ZPf3p6XQ9zGKSQ=
Received: by smtp.zohomail.com with SMTPS id 179250065579496.0408189778044;
	Tue, 20 Oct 2026 05:50:55 -0700 (PDT)
Message-ID: <eb20c279-d582-48cd-b461-59979b529c42@zohomail.com>
Date: Tue, 20 Oct 2026 20:50:50 +0800
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/mbox: Return success for
 CXL_MBOX_CMD_RC_BACKGROUND
To: Richard Cheng <icheng@nvidia.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 iweiny@kernel.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261020090352.939795-1-ming.li@zohomail.com>
 <atc3PJRk3M_RBmMG@MWDK4CY14F>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <atc3PJRk3M_RBmMG@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112272c91931678d05cc42444b18d0000589a94c8ae7a9166dc285a88179926243f8b57b18cfc55f31f:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 10/20/2026 5:42 PM, Richard Cheng wrote:
> On Tue, Oct 20, 2026 at 05:03:52PM +0800, Li Ming wrote:
>> In CXL subsystem, each mbox command hw return code is mapped to a
>> corresponding errno value. Currently, CXL_MBOX_CMD_RC_BACKGROUND is
>> mapped to -ENXIO.
>>
>> However, a BACKGROUND hw return code indicates that the command has been
>> accepted by the device and continues execution asynchronously. It does
>> not indicate a command failure.
>>
> Hi Li,
Hi Richard,
>
> Can we have the spec section written here ?
Sure.
> Btw I wonder how you trigger the error ?

We cannot trigger this error, currently, driver does not check/use BACKGROUND's error. it is found by review, please see [1]. 

[1]: https://lore.kernel.org/linux-cxl/cover.1791949910.git.alison.schofield@intel.com/T/#mc7764b9f3f470adf62292000299e8288d2241c3d

Ming

>
> Best regards,
> Richard Cheng.
>  
>> Return 0 instead of -ENXIO for CXL_MBOX_CMD_RC_BACKGROUND so that
>> callers do not treat a successfully started background operation as an
>> error.
>>
>> Fixes: 92fcc1abab09 ("cxl/mbox: Improve handling of mbox_cmd hw return codes")
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>>  drivers/cxl/cxlmem.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index c401e3a1af06..cc71d7a84cdc 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -160,7 +160,7 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>>   */
>>  #define CMD_CMD_RC_TABLE							\
>>  	C(SUCCESS, 0, NULL),							\
>> -	C(BACKGROUND, -ENXIO, "background cmd started successfully"),           \
>> +	C(BACKGROUND, 0, "background cmd started successfully"),		\
>>  	C(INPUT, -ENXIO, "cmd input was invalid"),				\
>>  	C(UNSUPPORTED, -ENXIO, "cmd is not supported"),				\
>>  	C(INTERNAL, -ENXIO, "internal device error"),				\
>> -- 
>> 2.43.0
>>

