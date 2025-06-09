Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C097D17A2EF;
	Mon,  9 Jun 2025 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466704; cv=none; b=YXk/oRv7b3pQizi0Gdvmz5KnWB4dSLZ41nFGOxT6AaWK89vcSbsGREDIoaVCj8m7sP5szynjGOD7oWs9rrKVFgYThYvI+gNevn/k3c6dLx1zDVMrO7Exo4DMEUBeEQm9vD7vgAEwveJsVoJq8XnWhfO2nZlMzWWgsj267LsbcLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466704; c=relaxed/simple;
	bh=C7Cx3n/+cQHw1TV8E4JL6MObu0M1N20UMqS4WPfR0oU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6wud8Z027QDxVG9NkVrE6wfX3iCPg4M07pPauqv4PLvWGFJ/Yj1zSuHknrXqJFZDaPkis/J9rxZChupLcD7owm4cERG05bDwlUesGOtYirScxk6RIz9r06PHidDa/SBNZGzR9eLPRq5MW+Dq+/ZCVD2EuATzOURjO62rimAQUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bG85y1Nvjz6M4qL;
	Mon,  9 Jun 2025 18:57:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 647FB1404FE;
	Mon,  9 Jun 2025 18:58:19 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Jun
 2025 12:58:18 +0200
Date: Mon, 9 Jun 2025 11:58:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <corbet@lwn.net>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<darren.kenny@oracle.com>
Subject: Re: [PATCH] Documentation: cxl: fix typos and improve clarity in
 memory-devices.rst
Message-ID: <20250609115817.00003017@huawei.com>
In-Reply-To: <20250531075209.3334261-1-alok.a.tiwari@oracle.com>
References: <20250531075209.3334261-1-alok.a.tiwari@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 31 May 2025 00:51:58 -0700
Alok Tiwari <alok.a.tiwari@oracle.com> wrote:

> This patch corrects several typographical issues and improves phrasing
> in memory-devices.rst:
> 
> - Fixes duplicate word ("1 one") and adjusts phrasing for clarity.
> - Adds missing hyphen in "on-device".
> - Corrects "a give memory device" to "a given memory device".
> - fix singular/plural "decoder resource" -> "decoder resources".
> - Clarifies "spans to Host Bridges" -> "spans two Host Bridges".
> 
> These changes improve readability and accuracy of the documentation.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
One additional comment given you are touching this text.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>  Documentation/driver-api/cxl/memory-devices.rst | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> index d732c42526df..e9e2952a967d 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -29,8 +29,8 @@ Platform firmware enumerates a menu of interleave options at the "CXL root port"
>  (Linux term for the top of the CXL decode topology). From there, PCIe topology
>  dictates which endpoints can participate in which Host Bridge decode regimes.
>  Each PCIe Switch in the path between the root and an endpoint introduces a point
> -at which the interleave can be split. For example platform firmware may say at a
> -given range only decodes to 1 one Host Bridge, but that Host Bridge may in turn
> +at which the interleave can be split. For example, platform firmware may say at a

Should probably be "platform firmware may say that a given range"

> +given range only decodes to one Host Bridge, but that Host Bridge may in turn
>  interleave cycles across multiple Root Ports. An intervening Switch between a
>  port and an endpoint may interleave cycles across multiple Downstream Switch
>  Ports, etc.
> @@ -187,7 +187,7 @@ decodes them to "ports", "ports" decode to "endpoints", and "endpoints"
>  represent the decode from SPA (System Physical Address) to DPA (Device Physical
>  Address).
>  
> -Continuing the RAID analogy, disks have both topology metadata and on device
> +Continuing the RAID analogy, disks have both topology metadata and on-device
>  metadata that determine RAID set assembly. CXL Port topology and CXL Port link
>  status is metadata for CXL.mem set assembly. The CXL Port topology is enumerated
>  by the arrival of a CXL.mem device. I.e. unless and until the PCIe core attaches
> @@ -197,7 +197,7 @@ the Linux PCI core to tear down switch-level CXL resources because the endpoint
>  ->remove() event cleans up the port data that was established to support that  
>  Memory Expander.
>  
> -The port metadata and potential decode schemes that a give memory device may
> +The port metadata and potential decode schemes that a given memory device may
>  participate can be determined via a command like::
>  
>      # cxl list -BDMu -d root -m mem3
> @@ -249,8 +249,8 @@ participate can be determined via a command like::
>  ...which queries the CXL topology to ask "given CXL Memory Expander with a kernel
>  device name of 'mem3' which platform level decode ranges may this device
>  participate". A given expander can participate in multiple CXL.mem interleave
> -sets simultaneously depending on how many decoder resource it has. In this
> -example mem3 can participate in one or more of a PMEM interleave that spans to
> +sets simultaneously depending on how many decoder resources it has. In this
> +example mem3 can participate in one or more of a PMEM interleave that spans two
>  Host Bridges, a PMEM interleave that targets a single Host Bridge, a Volatile
>  memory interleave that spans 2 Host Bridges, and a Volatile memory interleave
>  that only targets a single Host Bridge.

