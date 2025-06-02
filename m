Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA001FDD;
	Mon,  2 Jun 2025 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748885117; cv=none; b=FjDqOx6uXKgass+z8XYFEinWudNwwSfccMfo4PVh9NaSIABbzwY+PFwXh7sNIqnzuGLnusJWf1Uvl4seOy2QUZ0wYrq65INPEc59i1hENEeIyas8D5vA51tV12liiki3ba/99QGqY0S2uwN4lQ/QFGoF/zg27p3U6BSfm1+WxGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748885117; c=relaxed/simple;
	bh=/skQwB1cZMZ5ydmADMVfyG7s15UpTncCW4C9EISzA2o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G03+T/nwcjjw7cm1Jmc6bAWv2TWEjQ9rzAgAq6d94lRCyRZDaw5gAA64dfj2WiYh3erFYguVqdAylc7fHrc2mCa/OxIcbrTF8WPqWVqySw0VXoHF3CPMt10V3Sws1WQG0jJnSMnYx/pWAgLloVBwPcaLeT9/UEyErGx/O9KVo04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bB10H6yNbz6HJcp;
	Tue,  3 Jun 2025 01:23:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C58171400D9;
	Tue,  3 Jun 2025 01:25:11 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Jun 2025 19:25:11 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 2 Jun 2025 19:25:11 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Li Ming <ming.li@zohomail.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 1/1] cxl/edac: Fix the min_scrub_cycle of a region
 miscalculation
Thread-Topic: [RFC PATCH 1/1] cxl/edac: Fix the min_scrub_cycle of a region
 miscalculation
Thread-Index: AQHb0V6BLsbEFutoIk+fqAJdROItN7PrXNGAgAQsgOCAAG61AIAAJJ5A
Date: Mon, 2 Jun 2025 17:25:11 +0000
Message-ID: <d036c22fc0e348a3ba7ecb0b4dbf35ba@huawei.com>
References: <20250530122852.10139-1-ming.li@zohomail.com>
	<aDn4o8Fw91vQ9D-D@aschofie-mobl2.lan>
	<bba0fc4616d54babb2b0113967acc95f@huawei.com>
 <aD3V1MbVV7RZmbu0@aschofie-mobl2.lan>
In-Reply-To: <aD3V1MbVV7RZmbu0@aschofie-mobl2.lan>
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
>Sent: 02 June 2025 17:48
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: Li Ming <ming.li@zohomail.com>; dave@stgolabs.net; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>vishal.l.verma@intel.com; ira.weiny@intel.com; dan.j.williams@intel.com; l=
inux-
>cxl@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: Re: [RFC PATCH 1/1] cxl/edac: Fix the min_scrub_cycle of a region
>miscalculation
>
>On Mon, Jun 02, 2025 at 08:23:34AM +0000, Shiju Jose wrote:
>> >-----Original Message-----
>> >From: Alison Schofield <alison.schofield@intel.com>
>> >Sent: 30 May 2025 19:28
>> >To: Li Ming <ming.li@zohomail.com>
>> >Cc: dave@stgolabs.net; Jonathan Cameron
>> ><jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>> >vishal.l.verma@intel.com; ira.weiny@intel.com;
>> >dan.j.williams@intel.com; Shiju Jose <shiju.jose@huawei.com>; linux-
>> >cxl@vger.kernel.org; linux-kernel@vger.kernel.org
>> >Subject: Re: [RFC PATCH 1/1] cxl/edac: Fix the min_scrub_cycle of a
>> >region miscalculation
>> >
>> >On Fri, May 30, 2025 at 08:28:52PM +0800, Li Ming wrote:
>> >> When trying to update the scrub_cycle value of a cxl region, which
>> >> means updating the scrub_cycle value of each memdev under a cxl
>> >> region. cxl driver needs to guarantee the new scrub_cycle value is
>> >> greater than the min_scrub_cycle value of a memdev, otherwise the
>> >> updating operation will fail(Per Table 8-223 in CXL r3.2 section
>8.2.10.9.11.1).
>> >>
>> >> Current implementation logic of getting the min_scrub_cycle value
>> >> of a cxl region is that getting the min_scrub_cycle value of each
>> >> memdevs under the cxl region, then using the minimum
>> >> min_scrub_cycle value as the region's min_scrub_cycle. Checking if
>> >> the new scrub_cycle value is greater than this value. If yes,
>> >> updating the new scrub_cycle value to each memdevs. The issue is
>> >> that the new scrub_cycle value is possibly greater than the minimum
>> >> min_scrub_cycle value of all memdevs but less than the maximum
>> >> min_scrub_cycle value of all memdevs if memdevs have a different
>> >> min_scrub_cycle value. The updating operation will always fail on
>> >> these memdevs which have a greater min_scrub_cycle than the new
>scrub_cycle.
>> >>
>> >> The correct implementation logic is to get the maximum value of
>> >> these memdevs' min_scrub_cycle, check if the new scrub_cycle value
>> >> is greater than the value. If yes, the new scrub_cycle value is fit f=
or the
>region.
>> >>
>> >> The change also impacts the result of
>> >> cxl_patrol_scrub_get_min_scrub_cycle(), the interface returned the
>> >> minimum min_scrub_cycle value among all memdevs under the region
>> >> before the change. The interface will return the maximum
>> >> min_scrub_cycle value among all memdevs under the region with the
>change.
>> >>
>> >> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> >> ---
>> >> I made this change based on my understanding on the SPEC and
>> >> current CXL EDAC code, but I am not sure if it is a bug or it is desi=
gned this
>way.
>> >
>> >The attribute is defined to show (per
>> >Documentation/ABI/testing/sysfs-edac-
>> >scrub)
>> >   "Supported minimum scrub cycle duration in seconds by the memory
>> >scrubber."
>> >
>> >Your fix, making the min the max of the mins, looks needed.
>> >
>> >I took a look at the max attribute. If the min is the max on the
>> >mins, then the max should be the max of the maxes. But, not true. We do
>this:
>> >
>> >instead: *max =3D U8_MAX * 3600; /* Max set by register size */
>> >
>> >The comment isn't helping me, esp since the sysfs description doesn't
>> >explain that we are using a constant max.
>> CXL spec r3.2 Table 8-222. Device Patrol Scrub Control Feature
>> Readable Attributes does not define a field for "max scrub cycle
>> supported".  Thus for max scrub cycle, returning max value of (U8_MAX) o=
f
>patrol scrub cycle field.
>
>Understand that now, thanks. I'm still wondering if both these deserve mor=
e
>explanation in Documentation/ABI/testing/sysfs-edac-scrub
>explaining the calculations. Like if the device represents an aggregate of
>devices, like a region, the min scrub cycle is the max of the mins, wherea=
s if the
>device is a single, it's exactly what the device returned.  And for max, e=
xplaining
>what you replied above.

Not sure is it appropriate to add these CXL scrub specific details to the g=
eneric file  =20
Documentation/ABI/testing/sysfs-edac-scrub?

CXL region specific details were added under section 1.2. Region based scru=
bbing
of Documentation/edac/scrub.rst. May be better add these details for CXL sp=
ecific
min and max scrub cycle calculation to the Documentation/edac/scrub.rst?

How do you want to post these suggested doc changes, in a follow-up patch n=
ow?

Thanks,
Shiju
>
>Regardless of this noise I'm making about the Docs.. I think Ming should g=
o
>ahead and v1 the fix for the min calc.
>
>--Alison
>
>>
>> Thanks,
>> Shiju
>> >
>> >
>> >>
>> >> base-commit: 9f153b7fb5ae45c7d426851f896487927f40e501 cxl/next
>> >> ---
>> >>  drivers/cxl/core/edac.c | 8 ++++++--
>> >>  1 file changed, 6 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
>> >> index
>> >> 2cbc664e5d62..ad243cfe00e7 100644
>> >> --- a/drivers/cxl/core/edac.c
>> >> +++ b/drivers/cxl/core/edac.c
>> >> @@ -103,10 +103,10 @@ static int cxl_scrub_get_attrbs(struct
>> >cxl_patrol_scrub_context *cxl_ps_ctx,
>> >>  				u8 *cap, u16 *cycle, u8 *flags, u8 *min_cycle)
>> >{
>> >>  	struct cxl_mailbox *cxl_mbox;
>> >> -	u8 min_scrub_cycle =3D U8_MAX;
>> >>  	struct cxl_region_params *p;
>> >>  	struct cxl_memdev *cxlmd;
>> >>  	struct cxl_region *cxlr;
>> >> +	u8 min_scrub_cycle =3D 0;
>> >>  	int i, ret;
>> >>
>> >>  	if (!cxl_ps_ctx->cxlr) {
>> >> @@ -133,8 +133,12 @@ static int cxl_scrub_get_attrbs(struct
>> >cxl_patrol_scrub_context *cxl_ps_ctx,
>> >>  		if (ret)
>> >>  			return ret;
>> >>
>> >> +		/*
>> >> +		 * The min_scrub_cycle of a region is the maximum value
>> >among
>> >> +		 * the min_scrub_cycle of all the memdevs under the region.
>> >> +		 */
>> >>  		if (min_cycle)
>> >> -			min_scrub_cycle =3D min(*min_cycle, min_scrub_cycle);
>> >> +			min_scrub_cycle =3D max(*min_cycle, min_scrub_cycle);
>> >>  	}
>> >>
>> >>  	if (min_cycle)
>> >> --
>> >> 2.34.1
>> >>
>>

