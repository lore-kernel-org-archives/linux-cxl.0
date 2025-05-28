Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15CB1632C8;
	Wed, 28 May 2025 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748449277; cv=none; b=I3gIKy2wI18rwh6akO9kc5h6sKXYBWSsyL5zW9F26fsjh1mg1eHZgmegxiv5U5tZPwZ/ix0TiWyTrrAY/dCHShykQ2P00ucczXLRChaN02wp/4+AsQFwbif8LoZXhei/BIAylBk9BROfC8Y3AzJVlcarPbK6puiAPDYJNlu8lZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748449277; c=relaxed/simple;
	bh=qS1gHsWMRI6Lyh/zqh0ANB9xHCaIG1o65jbSeKh8QG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=drudts38yKJx7TEd90WA9uRNoPb4e6LcjaXy2NVwob6ZcUw2CMGtNCdKLhZOuvkOpfOzd/RlgIWEdolapnbHhSlqjGB7j6Rm9R0qMh0IvR3WIaE+scJLk0KLTfoc6EAz8PhQ/XwEqVX8W2cqrJsvF5mmmEHgET7LKNkhP5u9O98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b6vrN6Ykrz6M4GB;
	Thu, 29 May 2025 00:21:08 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id AE7F81402F6;
	Thu, 29 May 2025 00:21:11 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 May 2025 18:21:11 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 28 May 2025 18:21:11 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>, Fan Ni
	<fan.ni@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH next] cxl: fix return value in
 cxlctl_validate_set_features()
Thread-Topic: [PATCH next] cxl: fix return value in
 cxlctl_validate_set_features()
Thread-Index: AQHbz6gs+BvlS7zgN0afPd/wpn1fvrPoB9WAgAAuyyA=
Date: Wed, 28 May 2025 16:21:11 +0000
Message-ID: <3cf2e87f32934c6d84ede6415206a352@huawei.com>
References: <aDbFPSCujpJLY1if@stanley.mountain>
 <aDcqO5hlGrRXzIPT@aschofie-mobl2.lan>
In-Reply-To: <aDcqO5hlGrRXzIPT@aschofie-mobl2.lan>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>-----Original Message-----
>From: Alison Schofield <alison.schofield@intel.com>
>Sent: 28 May 2025 16:23
>To: Shiju Jose <shiju.jose@huawei.com>; Dan Carpenter
><dan.carpenter@linaro.org>
>Cc: Davidlohr Bueso <dave@stgolabs.net>; Jonathan Cameron
><jonathan.cameron@huawei.com>; Dave Jiang <dave.jiang@intel.com>; Vishal
>Verma <vishal.l.verma@intel.com>; Ira Weiny <ira.weiny@intel.com>; Dan
>Williams <dan.j.williams@intel.com>; Li Ming <ming.li@zohomail.com>; Fan N=
i
><fan.ni@samsung.com>; linux-cxl@vger.kernel.org; linux-
>kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
>Subject: Re: [PATCH next] cxl: fix return value in cxlctl_validate_set_fea=
tures()
>
>On Wed, May 28, 2025 at 11:11:41AM +0300, Dan Carpenter wrote:
>> The cxlctl_validate_set_features() function is type bool.  It's
>> supposed to return true for valid requests and false for invalid.
>> However, this error path returns ERR_PTR(-EINVAL) which is true when
>> it was intended to return false.
>
>Shiju - Can you trace this one through and add the impact statement?
>Wondering if this is going to fail gracefully, or badly, further down this=
 path?

Hi Alison,

This is introduced when following fwctl specific code
move out of common  function (use both in fwctl and edac path)
get_support_feature_info() to fwctl specific function
cxlctl_validae_set_feature().
"if (rpc_in->op_size < sizeof(uuid_t))
      return ERR_PTR(-EINVAL);"

This may have an impact on fwctl side if the above check pass.

Thanks,
Shiju

>
>>
>> Fixes: f76e0bbc8bc3 ("cxl: Update prototype of function
>> get_support_feature_info()")
>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>> ---
>>  drivers/cxl/core/features.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
>> index 6f2eae1eb126..7c750599ea69 100644
>> --- a/drivers/cxl/core/features.c
>> +++ b/drivers/cxl/core/features.c
>> @@ -544,7 +544,7 @@ static bool cxlctl_validate_set_features(struct
>cxl_features_state *cxlfs,
>>  	u32 flags;
>>
>>  	if (rpc_in->op_size < sizeof(uuid_t))
>> -		return ERR_PTR(-EINVAL);
>> +		return false;
>>
>>  	feat =3D cxl_feature_info(cxlfs, &rpc_in->set_feat_in.uuid);
>>  	if (IS_ERR(feat))
>> --
>> 2.47.2
>>

