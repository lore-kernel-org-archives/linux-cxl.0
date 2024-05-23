Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFCE2B9D4
	for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478270; cv=none; b=jCsVGMgT7aSBd0uvfm/PkaafXYrdv3EIUfJMpVUDzWoW2RGX+1iycsS1yo9NvZByQrfBVHmd432NZ8Dxii+gqji5paW3oFFk4Jxu9olj1r8EAamQQozTmbBv8NgE9E0gk4G3WXC/fqOfYD82b1fW3v9+iuMhwRpAGDC5HO5tR9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478270; c=relaxed/simple;
	bh=QAIqg9mgVTW+v/WKmS38VYX8BKVgnA08MHSyfX830Cw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEJ37Leibb4z5qXZzr/J7M9ZfC9xmdrUyCe3EFjMvxHH4Bn0Ul2GxNWZ65AqKmPArtuLbp8AwudUIOHv7fwdv57kXrn9OKvBC0QyPnUuOsW7Tq722EleFD7vUDr0enmnMn99Q37sqOU7roSPV6KwnB8uMgmV4TmClAE/QSJiIdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VlX8r6c2qz6J6lS;
	Thu, 23 May 2024 23:27:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EE957140A1B;
	Thu, 23 May 2024 23:31:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 May
 2024 16:31:03 +0100
Date: Thu, 23 May 2024 16:31:02 +0100
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
Message-ID: <20240523163102.0000502f@Huawei.com>
In-Reply-To: <Zk0vJIrBQTxzgpK2@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
	<20240418232902.583744-10-fan.ni@samsung.com>
	<877cgkxzal.fsf@pond.sub.org>
	<Zivk37xBGPsL_yo5@debian>
	<87h6fkob0t.fsf@pond.sub.org>
	<ZjLCS8yJC-OvPsUS@debian>
	<20240520175012.000045fe@Huawei.com>
	<Zk0vJIrBQTxzgpK2@debian>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 21 May 2024 16:32:52 -0700
fan <nifan.cxl@gmail.com> wrote:

> From 9d6d774ec973d22c0f662b32385345a88b14cc55 Mon Sep 17 00:00:00 2001
> From: Fan Ni <fan.ni@samsung.com>
> Date: Tue, 20 Feb 2024 09:48:31 -0800
> Subject: [PATCH 11/14] hw/cxl/events: Add qmp interfaces to add/release
>  dynamic capacity extents
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
>       "selection-policy": "prescriptive",
>       "region": 0,
>       "tag": "",
As below, should we make the tag optional? (prefix it with * and
the callback will gain a has_x bool.)
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
>       "removal-policy":"prescriptive",
>       "forced-removal": false,
>       "sanitize-on-release": false,
>       "region": 0,
>       "tag": "",
This suggests to me we should use some optional parameters with
sensible defaults (off and not present) for
tag, sanitize-on-release and forced-removal.


>       "extents": [
>       {
>           "offset": 134217728,
>           "len": 134217728
>       }
>       ]
>   }
> }


> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 4281726dec..a3a900eb2e 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -361,3 +361,146 @@
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
> +#     where the extent belongs to.
> +#
> +# @len: The length of the extent in bytes.
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
> +# @CXLExtSelPolicy:
> +#
> +# The policy to use for selecting which extents comprise the added
> +# capacity, as defined in cxl spec r3.1 Table 7-70.
> +#
> +# @free: 0h = Free
> +#
> +# @contiguous: 1h = Continuous
> +#
> +# @prescriptive: 2h = Prescriptive
> +#
> +# @enable-shared-access: 3h = Enable Shared Access
> +#
> +# Since: 9.1
> +##
> +{ 'enum': 'CXLExtSelPolicy',
> +  'data': ['free',
> +           'contiguous',
> +           'prescriptive',
> +           'enable-shared-access']
> +}
> +
> +##
> +# @cxl-add-dynamic-capacity:
> +#
> +# Command to initiate to add dynamic capacity extents to a host.  It
> +# simulates operations defined in cxl spec r3.1 7.6.7.6.5.
> +#
> +# @path: CXL DCD canonical QOM path.
> +#
> +# @host-id: The "Host ID" field as defined in cxl spec r3.1
> +#     Table 7-70.
> +#
> +# @selection-policy: The "Selection Policy" bits as defined in
> +#     cxl spec r3.1 Table 7-70.  It specifies the policy to use for
> +#     selecting which extents comprise the added capacity.
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
> +            'selection-policy': 'CXLExtSelPolicy',
> +            'region': 'uint8',
> +            'tag': 'str',
> +            'extents': [ 'CXLDynamicCapacityExtent' ]
> +           }
> +}
> +
> +##
> +# @CXLExtRemovalPolicy:
> +#
> +# The policy to use for selecting which extents comprise the released
> +# capacity, defined in the "Flags" field in cxl spec r3.1 Table 7-71.
> +#
> +# @tag-based: value = 0h.  Extents are selected by the device based
> +#     on tag, with no requirement for contiguous extents.
> +#
> +# @prescriptive: value = 1h.  Extent list of capacity to release is
> +#     included in the request payload.
> +#
> +# Since: 9.1
> +##
> +{ 'enum': 'CXLExtRemovalPolicy',
> +  'data': ['tag-based',
> +           'prescriptive']
> +}
> +
> +##
> +# @cxl-release-dynamic-capacity:
> +#
> +# Command to initiate to release dynamic capacity extents from a
> +# host.  It simulates operations defined in cxl spec r3.1 7.6.7.6.6.
> +#
> +# @path: CXL DCD canonical QOM path.
> +#
> +# @host-id: The "Host ID" field as defined in cxl spec r3.1
> +#     Table 7-71.
> +#
> +# @removal-policy: Bit[3:0] of the "Flags" field as defined in cxl
> +#     spec r3.1 Table 7-71.
> +#
> +# @forced-removal: Bit[4] of the "Flags" field in cxl spec r3.1
> +#     Table 7-71.  When set, device does not wait for a Release
> +#     Dynamic Capacity command from the host.  Host immediately
> +#     loses access to released capacity.
> +#
> +# @sanitize-on-release: Bit[5] of the "Flags" field in cxl spec r3.1
> +#     Table 7-71.  When set, device should sanitize all released
> +#     capacity as a result of this request.
> +#
> +# @region: The "Region Number" field as defined in cxl spec r3.1
> +#     Table 7-71.  The dynamic capacity region where the capacity
> +#     is being added.  Valid range is from 0-7.
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
> +            'removal-policy': 'CXLExtRemovalPolicy',
> +            'forced-removal': 'bool',
> +            'sanitize-on-release': 'bool',
> +            'region': 'uint8',
> +            'tag': 'str',
> +            'extents': [ 'CXLDynamicCapacityExtent' ]
> +           }
> +}

