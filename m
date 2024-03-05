Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8FB12A16B
	for <linux-cxl@vger.kernel.org>; Tue,  5 Mar 2024 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654956; cv=none; b=LJbktH/uUjQgKvA8KbiZpysIhPNaT810qe6mlqJKQ11IXlJYgeXd0Rgjp7eQYCSnWs8CekZTqoJbNpuqxUD5Ja9AS0ZdUrRC0+b/nw+OHNUea1AH7b3ASWFCRZLKB0gOO6Nzyz8hkkZdqj54xdKrUF+U6xdNojLeGb6JvHdGGjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654956; c=relaxed/simple;
	bh=QGSEZHQm1+TRPWWwBFnU1x6CujSiDcnx8cVeCHRWveY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWx30HlRZZhepoVwwo02u7efshA5hVldwbd+0tElq/T5pVQjANNkLOCiIeah/1wfxebZq+eoLOHQBmr4jh6+LhoYhsOlEUU8K9QgVTAlGLBYbPgsU/mUFkUQkzm+gmG1+rjTWmEt5HplJLbHeJAVK4FZPaPAFhZasjVsOQpgwz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tq0lJ4frDz6J7ft;
	Wed,  6 Mar 2024 00:05:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 42238140DE1;
	Wed,  6 Mar 2024 00:09:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 5 Mar
 2024 16:09:09 +0000
Date: Tue, 5 Mar 2024 16:09:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 13/13] qapi/cxl.json: Add QMP interfaces to print out
 accepted and pending DC extents
Message-ID: <20240305160908.000010c5@Huawei.com>
In-Reply-To: <20240304194331.1586191-14-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
	<20240304194331.1586191-14-nifan.cxl@gmail.com>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon,  4 Mar 2024 11:34:08 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> With the change, we add the following two QMP interfaces to print out
> extents information in the device,
> 1. cxl-display-accepted-dc-extents: print out the accepted DC extents in
>    the device;
> 2. cxl-display-pending-to-add-dc-extents: print out the pending-to-add
>    DC extents in the device;
> The output is appended to a file passed to the command and by default
> it is /tmp/dc-extent.txt.
Hi Fan,

Is there precedence for this sort of logging to a file from a qmp
command?  I can see something like this being useful.

A few comments inline.

Jonathan


> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/mem/cxl_type3.c       | 80 ++++++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c | 12 ++++++
>  qapi/cxl.json            | 32 ++++++++++++++++
>  3 files changed, 124 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 5bd64e604e..6a08e7ae40 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -2089,6 +2089,86 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint8_t region_id,
>                                       region_id, records, errp);
>  }
>  
> +static void cxl_dcd_display_extent_list(const CXLType3Dev *dcd, const char *f,
> +                                        bool accepted_list, Error **errp)
> +{
> +    const CXLDCExtentList *list;
> +    CXLDCExtent *ent;
> +    FILE *fp = NULL;
> +    int i = 0;
> +
> +    if (!dcd->dc.num_regions) {
> +        error_setg(errp, "No dynamic capacity support from the device");
> +        return;
> +    }
> +
> +    if (!f) {
> +        fp = fopen("/tmp/dc-extent.txt", "a+");
> +    } else {
> +        fp = fopen(f, "a+");
> +    }
> +
> +    if (!fp) {
> +        error_setg(errp, "Open log file failed");
> +        return;
> +    }
> +    if (accepted_list) {
> +        list = &dcd->dc.extents;
> +        fprintf(fp, "Print accepted extent info:\n");
> +    } else {
> +        list = &dcd->dc.extents_pending_to_add;
> +        fprintf(fp, "Print pending-to-add extent info:\n");
> +    }
> +
> +    QTAILQ_FOREACH(ent, list, node) {
> +        fprintf(fp, "%d: [0x%lx - 0x%lx]\n", i++, ent->start_dpa,
> +                               ent->start_dpa + ent->len);
> +    }
> +    fprintf(fp, "In total, %d extents printed!\n", i);
> +    fclose(fp);
> +}

> +void qmp_cxl_display_pending_to_add_dc_extents(const char *path, const char *f,
> +                                               Error **errp)
> +{
> +    Object *obj;
> +    CXLType3Dev *dcd;
> +
> +    obj = object_resolve_path(path, NULL);

As an aside, we could probably flatten a lot of these cases into
object_resolve_path_type()

> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve path");
> +        return;
> +    }
> +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +        error_setg(errp, "Path not point to a valid CXL type3 device");
> +        return;
> +    }
> +
> +
> +    dcd = CXL_TYPE3(obj);
> +    cxl_dcd_display_extent_list(dcd, f, false, errp);
> +}
> +
>  static void ct3_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 2645004666..6f10300ec6 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -420,3 +420,35 @@
>              'extents': [ 'CXLDCExtentRecord' ]
>             }
>  }
> +
> +##
> +# @cxl-display-accepted-dc-extents:
> +#
> +# Command to print out all the accepted DC extents in the device
> +#
> +# @path: CXL DCD canonical QOM path
> +# @output: path of output file to dump the results to

We take a path, but dump to the same file whatever this is set to?
I'm not sure what precedence there is for qom commands that
dump to a debug log.  Perhaps reference any other cases in the
patch description.  

> +#
> +# Since : 9.0
> +##
> +{ 'command': 'cxl-display-accepted-dc-extents',
> +  'data': { 'path': 'str',
> +            'output': 'str'
> +           }
> +}
> +
> +##
> +# @cxl-display-pending-to-add-dc-extents:
> +#
> +# Command to print out all the pending-to-add DC extents in the device
> +#
> +# @path: CXL DCD canonical QOM path
> +# @output: path of output file to dump the results to
> +#
> +# Since : 9.0
> +##
> +{ 'command': 'cxl-display-pending-to-add-dc-extents',
> +  'data': { 'path': 'str',
> +            'output': 'str'
> +           }
> +}

