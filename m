Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C153B137749
	for <linux-cxl@vger.kernel.org>; Mon, 20 May 2024 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716223821; cv=none; b=TS1lpYV2A5AhccPeH0yAD/xwYtlwkqIEbIObACnR47NHykGr1qub9I5X/sLd45yuOJT/eyzJXdSLLRS/2HjV4hbik2DJeEQIxDQwhSiGGJKXvqtN/YjAtqO8v62hP95uwVtPCgzkhuJ64OU7qH7kk/R/hhprzY8or+eknVkozSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716223821; c=relaxed/simple;
	bh=zawAcGNUD339bTUgizj2Mi4aDp0cuCQrp1ZLnHD9Pkc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTk3t5VfxjZL8/dk0xOFobG2R48vKwPlh766S29lvRMlJid8w7Ih0Vy3wGCAqhb7rE+63g6K4wmMXzw61ORyXOUla+m5lwOZ2QtmntKxXeJWAm/sVEe7REafR5dhU5r0dsncgED9CTEcd/59b35xWK/j4e3WMOe3nnhjqNtcke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vjk410C0dz6JB8l;
	Tue, 21 May 2024 00:46:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 155CC1408F9;
	Tue, 21 May 2024 00:50:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 20 May
 2024 17:50:14 +0100
Date: Mon, 20 May 2024 17:50:12 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: Markus Armbruster <armbru@redhat.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <gregory.price@memverge.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<jim.harris@samsung.com>, <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan
 Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240520175012.000045fe@Huawei.com>
In-Reply-To: <ZjLCS8yJC-OvPsUS@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
	<20240418232902.583744-10-fan.ni@samsung.com>
	<877cgkxzal.fsf@pond.sub.org>
	<Zivk37xBGPsL_yo5@debian>
	<87h6fkob0t.fsf@pond.sub.org>
	<ZjLCS8yJC-OvPsUS@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 1 May 2024 15:29:31 -0700
fan <nifan.cxl@gmail.com> wrote:

> From 873f59ec06c38645768ada452d9b18920a34723e Mon Sep 17 00:00:00 2001
> From: Fan Ni <fan.ni@samsung.com>
> Date: Tue, 20 Feb 2024 09:48:31 -0800
> Subject: [PATCH] hw/cxl/events: Add qmp interfaces to add/release dynamic
>  capacity extents
> Status: RO
> Content-Length: 25172
> Lines: 731
> 
> To simulate FM functionalities for initiating Dynamic Capacity Add
> (Opcode 5604h) and Dynamic Capacity Release (Opcode 5605h) as in CXL spec
> r3.1 7.6.7.6.5 and 7.6.7.6.6, we implemented two QMP interfaces to issue
> add/release dynamic capacity extents requests.
> 
> With the change, we allow to release an extent only when its DPA range
> is contained by a single accepted extent in the device. That is to say,
> extent superset release is not supported yet.
> 
> 1. Add dynamic capacity extents:
> 
> For example, the command to add two continuous extents (each 128MiB long)
> to region 0 (starting at DPA offset 0) looks like below:
> 
> { "execute": "qmp_capabilities" }
> 
> { "execute": "cxl-add-dynamic-capacity",
>   "arguments": {
>       "path": "/machine/peripheral/cxl-dcd0",
>       "host-id": 0,
>       "selection-policy": 2,
>       "region": 0,
>       "tag": "",
>       "extents": [
>       {
>           "offset": 0,
>           "len": 134217728
>       },
>       {
>           "offset": 134217728,
>           "len": 134217728
>       }
>       ]
>   }
> }
> 
> 2. Release dynamic capacity extents:
> 
> For example, the command to release an extent of size 128MiB from region 0
> (DPA offset 128MiB) looks like below:
> 
> { "execute": "cxl-release-dynamic-capacity",
>   "arguments": {
>       "path": "/machine/peripheral/cxl-dcd0",
>       "host-id": 0,
>       "flags": 1,
>       "region": 0,
>       "tag": "",
>       "extents": [
>       {
>           "offset": 134217728,
>           "len": 134217728
>       }
>       ]
>   }
> }
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Hi Fan,

A few trivial questions inline.  I don't feel particularly strongly
about breaking up the flags fields, but I'd like to understand your
reasoning for keeping them as single fields?

Is it mainly to keep aligned with the specification or something else?

Thanks,

Jonathan


>  #endif /* CXL_EVENTS_H */
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 4281726dec..27cf39f448 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -361,3 +361,93 @@
>  ##
>  {'command': 'cxl-inject-correctable-error',
>   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
> +
> +##
> +# @CXLDynamicCapacityExtent:
> +#
> +# A single dynamic capacity extent
> +#
> +# @offset: The offset (in bytes) to the start of the region
> +#     where the extent belongs to
> +#
> +# @len: The length of the extent in bytes
> +#
> +# Since: 9.1
> +##
> +{ 'struct': 'CXLDynamicCapacityExtent',
> +  'data': {
> +      'offset':'uint64',
> +      'len': 'uint64'
> +  }
> +}
> +
> +##
> +# @cxl-add-dynamic-capacity:
> +#
> +# Command to initiate to add dynamic capacity extents to a host.  It
> +# simulates operations defined in cxl spec r3.1 7.6.7.6.5.
> +#
> +# @path: CXL DCD canonical QOM path
> +#
> +# @host-id: The "Host ID" field as defined in cxl spec r3.1
> +#     Table 7-70.
> +#
> +# @selection-policy: The "Selection Policy" bits as defined in
> +#     cxl spec r3.1 Table 7-70.  It specifies the policy to use for
> +#     selecting which extents comprise the added capacity.

Hmm. This one is defined as a selection of nameable choices.  Perhaps
worth an enum?  If we did do that, we'd also need to break the flags
on in the release flags below.


> +#
> +# @region: The "Region Number" field as defined in cxl spec r3.1
> +#     Table 7-70.  The dynamic capacity region where the capacity
> +#     is being added.  Valid range is from 0-7.
> +#
> +# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-70.
> +#
> +# @extents: The "Extent List" field as defined in cxl spec r3.1
> +#     Table 7-70.
> +#
> +# Since : 9.1
> +##
> +{ 'command': 'cxl-add-dynamic-capacity',
> +  'data': { 'path': 'str',
> +            'host-id': 'uint16',
> +            'selection-policy': 'uint8',
> +            'region': 'uint8',
> +            'tag': 'str',
> +            'extents': [ 'CXLDynamicCapacityExtent' ]
> +           }
> +}
> +
> +##
> +# @cxl-release-dynamic-capacity:
> +#
> +# Command to initiate to release dynamic capacity extents from a
> +# host.  It simulates operations defined in cxl spec r3.1 7.6.7.6.6.
> +#
> +# @path: CXL DCD canonical QOM path
> +#
> +# @host-id: The "Host ID" field as defined in cxl spec r3.1
> +#     Table 7-71.
> +#
> +# @flags: The "Flags" field as defined in cxl spec r3.1 Table 7-71,
> +#     with bit[3:0] for removal policy, bit[4] for forced removal,
> +#     bit[5] for sanitize on release, bit[7:6] reserved.

This can be nicely broken up into removal policy enum plus two flags.
It might be worth doing so to give a nicer interface?

> +#
> +# @region: The dynamic capacity region where the extents will be
> +#     released.

This has a better definition in the add dynamic capacity entry above.

> +#
> +# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-71.
> +#
> +# @extents: The "Extent List" field as defined in cxl spec r3.1
> +#     Table 7-71.
> +#
> +# Since : 9.1
> +##
> +{ 'command': 'cxl-release-dynamic-capacity',
> +  'data': { 'path': 'str',
> +            'host-id': 'uint16',
> +            'flags': 'uint8',
> +            'region': 'uint8',
> +            'tag': 'str',
> +            'extents': [ 'CXLDynamicCapacityExtent' ]
> +           }
> +}

