Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166DD81ACA;
	Mon,  2 Jun 2025 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748852627; cv=none; b=bKb9JtUE9GRjorS+ahSBObXxkuQEpObM8+Q5OsSSLnzyU9qzOH1nmB0+8MpEtwno2VB9vPNQk/ePHJjLB6pAB+p8YSlFUrB1Pa/yX3tjE7ZbQk0pYjFG3l+dISa0zJKSvG5f05dlZneoqNsIon4C7ErndYpaLJ5FnEkBkYzXciE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748852627; c=relaxed/simple;
	bh=7H7Ew7VPJ4GDaygvhUKOLgVMOua5zf4WxmZkr4fy4u4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dXiD7YAYFEcT5h6GJlup5CoTjSzLcL1c2zgun7A93RMIhfQiVWbnBjJNPAdKlnx2BNNk8M1rFueiQuSToYenGd/g7wY1Atkdrm8Jy7DztfAjRK40kzNjvyDP5Wu8QioNlq34zCxqF8ZKF2sWzNK+oNvwpk4Txjst0qZurqXmqeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b9n0s253Pz6GDr7;
	Mon,  2 Jun 2025 16:23:25 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C2741402E9;
	Mon,  2 Jun 2025 16:23:35 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Jun 2025 10:23:34 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 2 Jun 2025 10:23:34 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>, Li Ming
	<ming.li@zohomail.com>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 1/1] cxl/edac: Fix the min_scrub_cycle of a region
 miscalculation
Thread-Topic: [RFC PATCH 1/1] cxl/edac: Fix the min_scrub_cycle of a region
 miscalculation
Thread-Index: AQHb0V6BLsbEFutoIk+fqAJdROItN7PrXNGAgAQsgOA=
Date: Mon, 2 Jun 2025 08:23:34 +0000
Message-ID: <bba0fc4616d54babb2b0113967acc95f@huawei.com>
References: <20250530122852.10139-1-ming.li@zohomail.com>
 <aDn4o8Fw91vQ9D-D@aschofie-mobl2.lan>
In-Reply-To: <aDn4o8Fw91vQ9D-D@aschofie-mobl2.lan>
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
>Sent: 30 May 2025 19:28
>To: Li Ming <ming.li@zohomail.com>
>Cc: dave@stgolabs.net; Jonathan Cameron <jonathan.cameron@huawei.com>;
>dave.jiang@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>dan.j.williams@intel.com; Shiju Jose <shiju.jose@huawei.com>; linux-
>cxl@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: Re: [RFC PATCH 1/1] cxl/edac: Fix the min_scrub_cycle of a region
>miscalculation
>
>On Fri, May 30, 2025 at 08:28:52PM +0800, Li Ming wrote:
>> When trying to update the scrub_cycle value of a cxl region, which
>> means updating the scrub_cycle value of each memdev under a cxl
>> region. cxl driver needs to guarantee the new scrub_cycle value is
>> greater than the min_scrub_cycle value of a memdev, otherwise the
>> updating operation will fail(Per Table 8-223 in CXL r3.2 section 8.2.10.=
9.11.1).
>>
>> Current implementation logic of getting the min_scrub_cycle value of a
>> cxl region is that getting the min_scrub_cycle value of each memdevs
>> under the cxl region, then using the minimum min_scrub_cycle value as
>> the region's min_scrub_cycle. Checking if the new scrub_cycle value is
>> greater than this value. If yes, updating the new scrub_cycle value to
>> each memdevs. The issue is that the new scrub_cycle value is possibly
>> greater than the minimum min_scrub_cycle value of all memdevs but less
>> than the maximum min_scrub_cycle value of all memdevs if memdevs have
>> a different min_scrub_cycle value. The updating operation will always
>> fail on these memdevs which have a greater min_scrub_cycle than the
>> new scrub_cycle.
>>
>> The correct implementation logic is to get the maximum value of these
>> memdevs' min_scrub_cycle, check if the new scrub_cycle value is
>> greater than the value. If yes, the new scrub_cycle value is fit for the=
 region.
>>
>> The change also impacts the result of
>> cxl_patrol_scrub_get_min_scrub_cycle(), the interface returned the
>> minimum min_scrub_cycle value among all memdevs under the region
>> before the change. The interface will return the maximum
>> min_scrub_cycle value among all memdevs under the region with the change=
.
>>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>> I made this change based on my understanding on the SPEC and current
>> CXL EDAC code, but I am not sure if it is a bug or it is designed this w=
ay.
>
>The attribute is defined to show (per Documentation/ABI/testing/sysfs-edac=
-
>scrub)
>   "Supported minimum scrub cycle duration in seconds by the memory
>scrubber."
>
>Your fix, making the min the max of the mins, looks needed.
>
>I took a look at the max attribute. If the min is the max on the mins, the=
n the
>max should be the max of the maxes. But, not true. We do this:
>
>instead: *max =3D U8_MAX * 3600; /* Max set by register size */
>
>The comment isn't helping me, esp since the sysfs description doesn't expl=
ain
>that we are using a constant max.
CXL spec r3.2 Table 8-222. Device Patrol Scrub Control Feature Readable Att=
ributes
does not define a field for "max scrub cycle supported".  Thus for max scru=
b=20
cycle, returning max value of (U8_MAX) of patrol scrub cycle field.=20

Thanks,
Shiju
>
>
>>
>> base-commit: 9f153b7fb5ae45c7d426851f896487927f40e501 cxl/next
>> ---
>>  drivers/cxl/core/edac.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c index
>> 2cbc664e5d62..ad243cfe00e7 100644
>> --- a/drivers/cxl/core/edac.c
>> +++ b/drivers/cxl/core/edac.c
>> @@ -103,10 +103,10 @@ static int cxl_scrub_get_attrbs(struct
>cxl_patrol_scrub_context *cxl_ps_ctx,
>>  				u8 *cap, u16 *cycle, u8 *flags, u8 *min_cycle)
>{
>>  	struct cxl_mailbox *cxl_mbox;
>> -	u8 min_scrub_cycle =3D U8_MAX;
>>  	struct cxl_region_params *p;
>>  	struct cxl_memdev *cxlmd;
>>  	struct cxl_region *cxlr;
>> +	u8 min_scrub_cycle =3D 0;
>>  	int i, ret;
>>
>>  	if (!cxl_ps_ctx->cxlr) {
>> @@ -133,8 +133,12 @@ static int cxl_scrub_get_attrbs(struct
>cxl_patrol_scrub_context *cxl_ps_ctx,
>>  		if (ret)
>>  			return ret;
>>
>> +		/*
>> +		 * The min_scrub_cycle of a region is the maximum value
>among
>> +		 * the min_scrub_cycle of all the memdevs under the region.
>> +		 */
>>  		if (min_cycle)
>> -			min_scrub_cycle =3D min(*min_cycle, min_scrub_cycle);
>> +			min_scrub_cycle =3D max(*min_cycle, min_scrub_cycle);
>>  	}
>>
>>  	if (min_cycle)
>> --
>> 2.34.1
>>

