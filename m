Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51713C77B7C
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 20:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbjEKUUr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 16:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238918AbjEKUUq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 16:20:46 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72092172D
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 13:20:43 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230511202040usoutp02629649ead652fe49f2ff9c297772d8cd~eMFJNl1Iz2680326803usoutp020;
        Thu, 11 May 2023 20:20:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230511202040usoutp02629649ead652fe49f2ff9c297772d8cd~eMFJNl1Iz2680326803usoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683836440;
        bh=3uO51E/5zgiGvhOQjpMwoF+Ds4elaWjEoOdJvEVLiF4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ZN9UvqcUso/TfxP/aivlRLrZYpWQMygn+vIB8X0aqWtW76quvtVgxFA/NC0u3jTQB
         vsfwn1cbM0eYBF5+xsQknFSm/+wg3Q0DRjbxb1Fl0UmhmnCyAO0YlSG9XU1i5fezde
         bt0D4MhH4pe0nrqV70tda7QySMrW63/PM3fWr1uA=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230511202040uscas1p16b30e91851a591465046f6088c86cda7~eMFI9dkAz1736217362uscas1p1e;
        Thu, 11 May 2023 20:20:40 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id B5.D9.20392.81E4D546; Thu,
        11 May 2023 16:20:40 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230511202040uscas1p185a11e72d5efa43f1e43e2ccd374a550~eMFIr2aiH1979319793uscas1p1B;
        Thu, 11 May 2023 20:20:40 +0000 (GMT)
X-AuditID: cbfec370-81ffe70000024fa8-62-645d4e18bf66
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 32.A3.38326.71E4D546; Thu,
        11 May 2023 16:20:39 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 11 May 2023 13:20:39 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Thu,
        11 May 2023 13:20:39 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Ben Cheatham <benjamin.cheatham@amd.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>
Subject: Re: [ndctl RFC] cxl/region: Add support to create dc region for
 dynamic capacity device
Thread-Topic: [ndctl RFC] cxl/region: Add support to create dc region for
        dynamic capacity device
Thread-Index: AQHZhDOkW8NLFMp5JkGvotudMJAplq9V76UAgAAJYoA=
Date:   Thu, 11 May 2023 20:20:39 +0000
Message-ID: <20230511202030.GA2092432@bgt-140510-bm03>
In-Reply-To: <6f1e7b65-fb95-ffc6-636c-032766f7c270@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A8D0059082E1EB458D30855A63EC4F90@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djXc7oSfrEpBqu3iFhMnPeNyWL61AuM
        FqtvrmG0OD/rFIvF84nPmSyWLnnEbHFrwjEmB3aP1kt/2Tx2zrrL7rF4z0smj82vXzB7TJ1d
        7/F5k1wAWxSXTUpqTmZZapG+XQJXxub2x4wF2/0rHp1/ytTAuNmui5GTQ0LARKJ7/RzGLkYu
        DiGBlYwSs7b9YoZwWpkkli+/wgZT9e3PUiaIxFpGicsrN0I5nxglnp3YzQrhLGOUaOzYzAzS
        wiagKLGvaztYu4iAjkTHyzvsIEXMAq+YJA417AIrEhZIknjw5RILRFGyxLwbO6AarCTut65j
        ArFZBFQlHiz/xwpi8wqYSfTtaQaq5+DgFLCWmD1dDCTMKCAm8f3UGrByZgFxiVtP5jNBnC0o
        sWj2HmYIW0zi366HUO8oStz//pIdol5HYsHuT2wQtp3Ejsd/oWxtiWULXzNDrBWUODnzCQtE
        r6TEwRU3WEB+kRB4wCFxa/JZdoiEi8T0SyeglklLXL0+lRnkTgmgv1Z95III50jMX7IFao61
        xMI/65kmMKrMQnL2LCQnzUJy0iwkJ81CctICRtZVjOKlxcW56anFxnmp5XrFibnFpXnpesn5
        uZsYgYnq9L/DBTsYb936qHeIkYmD8RCjBAezkgjv2yXRKUK8KYmVValF+fFFpTmpxYcYpTlY
        lMR5DW1PJgsJpCeWpGanphakFsFkmTg4pRqY2tbODmLxCWqY/7lQfpKImNaMm5YcJSrM6/R+
        7GP62ZKw1Pf6xuQk8ec75L/LCG9g2x5pdtDV3ezFv+bdtyZ0tWUyCUUznNHzOnrugNqXqxWF
        bMFnN82KkZKxmzNn/f/XPR3CdTnCUYuW/Um2tVv5R7IruO/r8wnLzubqc80N4Ombv2lhrcfz
        JSqZ8ipntq5Ya/Mj8e/0GDtOyQlqLzUPKguWh7eafRcumRd71XDBrH7B/n22yqIfrV7L//I4
        /c7mTt//NYf61k1L2dSyRKru2UNF6e0dl24xTu9fkBJW+Wl5mFl2WPlUVrlpcX7JbgUiMxyv
        zzC2Y33L9/WFQdw17btvdsd9f2v1Z7G4Tm+hEktxRqKhFnNRcSIAarw/wMMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWS2cA0SVfcLzbF4O0ES4uJ874xWUyfeoHR
        YvXNNYwW52edYrF4PvE5k8XSJY+YLW5NOMbkwO7Reukvm8fOWXfZPRbvecnksfn1C2aPqbPr
        PT5vkgtgi+KySUnNySxLLdK3S+DK2Nz+mLFgu3/Fo/NPmRoYN9t1MXJySAiYSHz7s5Spi5GL
        Q0hgNaPE+v/tjCAJIYFPjBItzTEQiWWMElfXH2IDSbAJKErs69oOZosI6Eh0vLzDDlLELPCK
        SeJQwy5mkISwQJLEgy+XWCCKkiVeb3sMZVtJ3G9dxwRiswioSjxY/o8VxOYVMJPo29PMArFt
        H6PErOZ9QIM4ODgFrCVmTxcDqWEUEJP4fmoNWC+zgLjErSfzmSBeEJBYsuc8M4QtKvHyMcRM
        CaBD739/yQ5RryOxYPcnNgjbTmLH479QtrbEsoWvmSFuEJQ4OfMJC0SvpMTBFTdYJgBdgmTd
        LCSjZiEZNQvJqFlIRi1gZF3FKF5aXJybXlFsmJdarlecmFtcmpeul5yfu4kRGOWn/x2O3MF4
        9NZHvUOMTByMhxglOJiVRHjfLolOEeJNSaysSi3Kjy8qzUktPsQozcGiJM4r5DoxXkggPbEk
        NTs1tSC1CCbLxMEp1cCUU3Lv0u2TP65+KE7ytlh9xidRnqWmePGN7vfPQ1ac2DU98Z3Du7mf
        d4p0rr3PUiYgoanKqepiopgX4/m6JDNhtqevxaQj8pFX/pXmbpiVsPrwtfCQK+vnekypjZH4
        spvvW8268DrDT6vjOJUcw4R5X6lKdkrt9ZmW++FQRMEHCw+1mC3id1OOWlcHvEyIesugetRb
        5579eaHMWAuddPf3Ux6F/Te5NVeaP9G+jP+2eUFd0yebqdHT3yTfdQ1I/D/X++XDIxkp1X4O
        hpz8u6RTfeorV5hvuP/4uUGJ8/JjvpWyp42MpP087OqNpd7c62F2PfSklyXp3PEHZuc/vze9
        LbOm5Ea/7tLPKW4vFimxFGckGmoxFxUnAgByb3ZvYQMAAA==
X-CMS-MailID: 20230511202040uscas1p185a11e72d5efa43f1e43e2ccd374a550
CMS-TYPE: 301P
X-CMS-RootMailID: 20230511180852uscas1p12736929a3b7da261a94fe661f151cc66
References: <CGME20230511180852uscas1p12736929a3b7da261a94fe661f151cc66@uscas1p1.samsung.com>
        <20230511180757.2091508-1-fan.ni@samsung.com>
        <6f1e7b65-fb95-ffc6-636c-032766f7c270@amd.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, May 11, 2023 at 02:47:00PM -0500, Ben Cheatham wrote:

> Hi Fan,
>=20
> I actually have a patch series that does this and adds cxl list support f=
or DC regions that I've been=20
> sitting on. I was going to wait to send it out until the kernel DCD suppo=
rt was a bit more mature,=20
> but since you sent this out I thought I may as well put the list support =
out there so we don't
> duplicate work. I've copy/pasted the patch below, feel free to add it to =
your patch/make modifications.

Hi Ben,
Thanks for letting me know.

I sent out the RFC only for those who want to have a early try of
DCD since early eanbling of DCD at both qemu and kernel side is out.

We can wait until the kernel side code is out for review and decide who
will carry this on.
Personally, I am OK to have you or anyone else to carry it on as
long as we advance the feature and do not do duplicate work.

Thanks,
Fan

>=20
> Subject: [PATCH] Add cxl list support for dynamic capacity regions
>=20
> Add support for printing dynamic capacity regions to cxl list. Region
> support is broken into two pieces: support for the cxl region, and
> support for device level dc regions. The device level dc regions are
> printed under the memdev in the list output since they are a memdev
> attribute in sysfs. There are a maximum of eight of these regions,
> only the regions that are present in sysfs are printed.
>=20
> Example output:
> (assume device has regions 0 and 1 populated, and region0 was created
>  using create-region -t dc)
> [
>     {
> 	"memdevs":[
> 	  {
> 	    "memdev":"mem0"
> 	    "pmem_size":536870912,
> 	    "ram_size":1,
> 	    "serial":0,
> 	    "host":"0000:0d:00.0",
> 	    "dc_regions":[
> 	      {
> 		"region_nr":0,
> 		"size":268435456,
> 		"base":268435456,
> 		"blk_size":2097152
> 	      },
> 	      {
> 		"region_nr":1,
> 		"size":268435456,
> 		"base":536870912,
> 		"blk_size":2097152
> 	      }
> 	    ]
> 	  }
> 	]
>     },
>     {
> 	"regions":[
> 	  {
> 	    "region":"region0",
> 	    "resource":19595788288,
> 	    "size":536870912,
> 	    "type":"dc",
> 	    "interleave_ways":1,
> 	    "interleave_granularity":256,
> 	    "decode_state":"commit"
> 	  }
> 	]
>     }
> ]
>=20
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  cxl/json.c         | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>  cxl/lib/libcxl.c   | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>  cxl/lib/libcxl.sym |  4 ++++
>  cxl/lib/private.h  |  8 +++++++
>  cxl/libcxl.h       |  7 ++++++
>  5 files changed, 139 insertions(+)
>=20
> diff --git a/cxl/json.c b/cxl/json.c
> index 9a4b5c7..df155f8 100644
> --- a/cxl/json.c
> +++ b/cxl/json.c
> @@ -480,6 +480,62 @@ err_jobj:
>  	return NULL;
>  }
> =20
> +static void util_cxl_memdev_dc_regions_to_json(struct json_object *jdev,=
 struct cxl_memdev *memdev,
> +			       unsigned long flags)
> +{
> +	struct json_object *jdc_array, *jdc_region, *jobj;
> +	u64 val;
> +
> +	jdc_array =3D json_object_new_array();
> +	if (!jdc_array)
> +		return;
> +
> +	for (int i =3D 0; i < CXL_MAX_DC_REGION; i++) {
> +		jdc_region =3D json_object_new_object();
> +		if (!jdc_region)
> +			continue;
> +
> +		/*
> +		 * Skip the region if the size is invalid, the rest is probably
> +		 * also invalid. If size is 0, the region is most likely unset.
> +		 */
> +		val =3D cxl_memdev_get_dc_region_size(memdev, i);
> +		if (val =3D=3D ULLONG_MAX || val =3D=3D 0) {
> +			json_object_put(jdc_region);
> +			continue;
> +		}
> +
> +		jobj =3D json_object_new_int(i);
> +		if (jobj)
> +			json_object_object_add(jdc_region, "region_nr", jobj);
> +
> +		jobj =3D util_json_object_size(val, flags);
> +		if (jobj) {
> +			json_object_object_add(jdc_region, "size", jobj);
> +		}
> +
> +		val =3D cxl_memdev_get_dc_region_base(memdev, i);
> +		if (val < ULLONG_MAX) {
> +			jobj =3D util_json_object_hex(val, flags);
> +			if (jobj)
> +				json_object_object_add(jdc_region, "base", jobj);
> +		}
> +
> +		val =3D cxl_memdev_get_dc_region_blk_size(memdev, i);
> +		if (val < ULLONG_MAX) {
> +			jobj =3D util_json_object_size(val, flags);
> +			if (jobj) {
> +				json_object_object_add(jdc_region, "blk_size", jobj);
> +			}
> +		}
> +
> +
> +		json_object_array_add(jdc_array, jdc_region);
> +	}
> +
> +	json_object_object_add(jdev, "dc_regions", jdc_array);
> +}
> +
>  struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
>  		unsigned long flags)
>  {
> @@ -552,6 +608,10 @@ struct json_object *util_cxl_memdev_to_json(struct c=
xl_memdev *memdev,
>  			json_object_object_add(jdev, "partition_info", jobj);
>  	}
> =20
> +	size =3D cxl_memdev_get_dc_size(memdev);
> +	if (size)
> +		util_cxl_memdev_dc_regions_to_json(jdev, memdev, flags);
> +
>  	json_object_set_userdata(jdev, memdev, NULL);
>  	return jdev;
>  }
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index ecdc242..0dcc79e 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -1211,6 +1211,37 @@ static void *add_cxl_memdev(void *parent, int id, =
const char *cxlmem_base)
>  		goto err_read;
>  	memdev->ram_size =3D strtoull(buf, NULL, 0);
> =20
> +	sprintf(path, "%s/dc/size", cxlmem_base);
> +	if (sysfs_read_attr(ctx, path, buf) < 0)
> +		memdev->dc_size =3D 0;
> +	else
> +		memdev->dc_size =3D strtoull(buf, NULL, 0);
> +
> +	for (unsigned int i =3D 0; i < CXL_MAX_DC_REGION; i++) {
> +		/*
> +		 * if the first read fails, assume the region doesn't exist
> +		 * and set the region to invalid values.
> +		 */
> +		sprintf(path, "%s/dc/base_region%d", cxlmem_base, i);
> +		if (sysfs_read_attr(ctx, path, buf) < 0) {
> +			memdev->dc_regions[i].base =3D ULLONG_MAX;
> +			memdev->dc_regions[i].size =3D 0;
> +			memdev->dc_regions[i].blk_size =3D 0;
> +			continue;
> +		}
> +		memdev->dc_regions[i].base =3D strtoull(buf, NULL, 0);
> +
> +		sprintf(path, "%s/dc/size_region%d", cxlmem_base, i);
> +		if (sysfs_read_attr(ctx, path, buf) < 0)
> +			goto err_read;
> +		memdev->dc_regions[i].size =3D strtoull(buf, NULL, 0);
> +
> +		sprintf(path,"%s/dc/blk_sz_region%d", cxlmem_base, i);
> +		if (sysfs_read_attr(ctx, path, buf) < 0)
> +			goto err_read;
> +		memdev->dc_regions[i].blk_size =3D strtoull(buf, NULL, 0);
> +	}
> +
>  	sprintf(path, "%s/payload_max", cxlmem_base);
>  	if (sysfs_read_attr(ctx, path, buf) < 0)
>  		goto err_read;
> @@ -1369,6 +1400,35 @@ CXL_EXPORT unsigned long long cxl_memdev_get_ram_s=
ize(struct cxl_memdev *memdev)
>  	return memdev->ram_size;
>  }
> =20
> +CXL_EXPORT unsigned long long cxl_memdev_get_dc_size(struct cxl_memdev *=
memdev)
> +{
> +	return memdev->dc_size;
> +}
> +
> +CXL_EXPORT unsigned long long cxl_memdev_get_dc_region_base(struct cxl_m=
emdev *memdev,
> +							    unsigned int region_nr)
> +{
> +	if (region_nr < CXL_MAX_DC_REGION)
> +		return memdev->dc_regions[region_nr].base;
> +	return ULLONG_MAX;
> +}
> +
> +CXL_EXPORT unsigned long long cxl_memdev_get_dc_region_size(struct cxl_m=
emdev *memdev,
> +							    unsigned int region_nr)
> +{
> +	if (region_nr < CXL_MAX_DC_REGION)
> +		return memdev->dc_regions[region_nr].size;
> +	return ULLONG_MAX;
> +}
> +
> +CXL_EXPORT unsigned long long cxl_memdev_get_dc_region_blk_size(struct c=
xl_memdev *memdev,
> +							    unsigned int region_nr)
> +{
> +	if (region_nr < CXL_MAX_DC_REGION)
> +		return memdev->dc_regions[region_nr].blk_size;
> +	return ULLONG_MAX;
> +}
> +
>  CXL_EXPORT const char *cxl_memdev_get_firmware_verison(struct cxl_memdev=
 *memdev)
>  {
>  	return memdev->firmware_version;
> diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> index 1434da6..e711273 100644
> --- a/cxl/lib/libcxl.sym
> +++ b/cxl/lib/libcxl.sym
> @@ -254,4 +254,8 @@ global:
>  LIBCXL_6 {
>  global:
>  	cxl_decoder_create_dc_region;
> +	cxl_memdev_get_dc_size;
> +	cxl_memdev_get_dc_region_base;
> +	cxl_memdev_get_dc_region_size;
> +	cxl_memdev_get_dc_region_blk_size;
>  } LIBCXL_5;
> diff --git a/cxl/lib/private.h b/cxl/lib/private.h
> index d49b560..968afaf 100644
> --- a/cxl/lib/private.h
> +++ b/cxl/lib/private.h
> @@ -19,6 +19,12 @@ struct cxl_pmem {
>  	char *dev_path;
>  };
> =20
> +struct cxl_dc_region {
> +	u64 base;
> +	u64 size;
> +	u64 blk_size;
> +};
> +
>  struct cxl_endpoint;
>  struct cxl_memdev {
>  	int id, major, minor;
> @@ -32,12 +38,14 @@ struct cxl_memdev {
>  	struct list_node list;
>  	unsigned long long pmem_size;
>  	unsigned long long ram_size;
> +	unsigned long long dc_size;
>  	int payload_max;
>  	size_t lsa_size;
>  	struct kmod_module *module;
>  	struct cxl_pmem *pmem;
>  	unsigned long long serial;
>  	struct cxl_endpoint *endpoint;
> +	struct cxl_dc_region dc_regions[CXL_MAX_DC_REGION];
>  };
> =20
>  struct cxl_dport {
> diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> index 1a54eee..c548abe 100644
> --- a/cxl/libcxl.h
> +++ b/cxl/libcxl.h
> @@ -18,6 +18,8 @@ typedef unsigned char uuid_t[16];
>  extern "C" {
>  #endif
> =20
> +#define CXL_MAX_DC_REGION 8
> +
>  struct cxl_ctx;
>  struct cxl_ctx *cxl_ref(struct cxl_ctx *ctx);
>  void cxl_unref(struct cxl_ctx *ctx);
> @@ -47,6 +49,11 @@ int cxl_memdev_get_minor(struct cxl_memdev *memdev);
>  struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *memdev);
>  unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
>  unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
> +unsigned long long cxl_memdev_get_dc_size(struct cxl_memdev *memdev);
> +unsigned long long cxl_memdev_get_dc_region_size(struct cxl_memdev *memd=
ev, unsigned int region_nr);
> +unsigned long long cxl_memdev_get_dc_region_base(struct cxl_memdev *memd=
ev, unsigned int region_nr);
> +unsigned long long cxl_memdev_get_dc_region_blk_size(struct cxl_memdev *=
memdev,
> +						     unsigned int region_nr);
>  const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
> =20
>  /* ABI spelling mistakes are forever */
> --=20
> 2.34.1=
