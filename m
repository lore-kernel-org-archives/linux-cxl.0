Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEE664A
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774815; cv=none; b=hz4YRxlgo4E+1LBuliyWf3daHeK8tq3Mh0n/myp1NkYjKNqqGZjbqGd3O90ApiDGAs9xutt1V2SAqWdRvxTnNWXUuCJ06+YLydtCZHgyZnmIHuXpRmtBplcsuMnEbYueGvIbZ86mL2Iz2hAcIpYPpUGc7n4F+UnrOkfzDF09VWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774815; c=relaxed/simple;
	bh=ZRXOPrf3xVDcra/aZJDOihLHAcdZLd8vDcL/Rn14DWc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UEbpHAHuiAkGSBBlCaZMvPGymY3G7RvxUeHoX50U9AwRl4XtPSv/MClhuVMVTsD0S0CWMHyBI3kKGce6aXpqXpdYhBQsDU8eKZdUYsQL8Xf8ib1o+F/sB8xiE4putO0pKzc9RD0PsOju9FwcEEw2ApalcnhHKQrXEjA/2KD0LqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtXPj4yqJz6J7Mw;
	Wed, 28 Aug 2024 00:02:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B1015140A35;
	Wed, 28 Aug 2024 00:06:48 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 17:06:41 +0100
Date: Tue, 27 Aug 2024 17:06:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v7 3/3] cxl: Add documentation to explain the shared
 link bandwidth calculation
Message-ID: <20240827170640.000007ab@Huawei.com>
In-Reply-To: <20240710222716.797267-4-dave.jiang@intel.com>
References: <20240710222716.797267-1-dave.jiang@intel.com>
	<20240710222716.797267-4-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 10 Jul 2024 15:24:02 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Create a kernel documentation to describe how the CXL shared upstream
> link bandwidth is calculated.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Oops. Missed this previously.  A few minor things inline.

J
> ---
>  .../driver-api/cxl/access-coordinates.rst     | 90 +++++++++++++++++++
>  Documentation/driver-api/cxl/index.rst        |  1 +
>  MAINTAINERS                                   |  1 +
>  3 files changed, 92 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/access-coordinates.rst
> 
> diff --git a/Documentation/driver-api/cxl/access-coordinates.rst b/Documentation/driver-api/cxl/access-coordinates.rst
> new file mode 100644
> index 000000000000..973e63872f06
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/access-coordinates.rst
> @@ -0,0 +1,90 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +==================================
> +CXL Access Coordinates Computation
> +==================================
> +
> +Shared Upstream Link Calculation
> +================================
> +For certain CXL region construction with endpoints behind CXL switches (SW) or
> +Root Ports (RP), there is the possibility of the total bandwdith for all
spell check. bandwidth
> +the endpoints behind a switch being more than the switch upstream link.

Could also be the Generic Port bit of the topology. Mind you I'm still failing
to come up with text for the qemu GP Documentation that the reviewers can follow
so maybe that's just too hard to describe here.  Could use weasel words.

"A similar situation can occur within the host, upstream of the root ports."


> +The CXL driver performs an additional pass after all the targets have
> +arrived for a region in order to recalculate the bandwidths with possible
> +upstream link being a limiting factor in mind.
> +
> +The algorithm assumes the configuration is a symmetric topology as that
> +maximizes performance. When asymmetric topology is detected, the calculation
> +is aborted when such topology is detected. An asymmetric topology is detected

is detected is duplicated.

> +during topology walk where the number of RPs detected as a grandparent is not
> +equal to the number of devices iterated in the same iteration loop.

Maybe make the point that asymmetric in terms of only properties of devices
is not detected. It just uses the first one I think?
> +
> +There can be multiple switches under a RP. There can be multiple RPs under
> +a CXL Host Bridge (HB). There can be multiple HBs under a CXL Fixed Memory
> +Window Structure (CFMWS).
> +
> +An example hierarchy:
> +
> +                CFMWS 0
> +                  |
> +         _________|_________
> +        |                   |
> +    ACPI0017-0          ACPI0017-1
> + GP0/HB0/ACPI0016-0   GP1/HB1/ACPI0016-1
> +    |          |        |           |
> +   RP0        RP1      RP2         RP3
> +    |          |        |           |
> +  SW 0       SW 1     SW 2        SW 3
> +  |   |      |   |    |   |       |   |
> + EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7
> +
> +Computation for the example hierarchy:
> +
> +Min (GP0 to CPU BW,
> +     Min(SW 0 Upstream Link to RP0 BW,
> +         Min(SW0SSLBIS for SW0DSP0 (EP0), EP0 DSLBIS, EP0 Upstream Link) +
> +         Min(SW0SSLBIS for SW0DSP1 (EP1), EP1 DSLBIS, EP1 Upstream link)) +
> +     Min(SW 1 Upstream Link to RP1 BW,
> +         Min(SW1SSLBIS for SW1DSP0 (EP2), EP2 DSLBIS, EP2 Upstream Link) +
> +         Min(SW1SSLBIS for SW1DSP1 (EP3), EP3 DSLBIS, EP3 Upstream link))) +
> +Min (GP1 to CPU BW,
> +     Min(SW 2 Upstream Link to RP2 BW,
> +         Min(SW2SSLBIS for SW2DSP0 (EP4), EP4 DSLBIS, EP4 Upstream Link) +
> +         Min(SW2SSLBIS for SW2DSP1 (EP5), EP5 DSLBIS, EP5 Upstream link)) +
> +     Min(SW 3 Upstream Link to RP3 BW,
> +         Min(SW3SSLBIS for SW3DSP0 (EP6), EP6 DSLBIS, EP6 Upstream Link) +
> +         Min(SW3SSLBIS for SW3DSP1 (EP7), EP7 DSLBIS, EP7 Upstream link))))
> +
> +
> +The calculation starts at cxl_region_shared_upstream_perf_update(). A xarray
> +is created to collect all the endpoint bandwidths via the
> +cxl_endpoint_gather_bandwidth() function. The min() of bandwidth from the
> +endpoint CDAT and the upstream link bandwidth is calculated. If the endpoint
> +has a CXL switch as a parent, then min() of calculated bandwidth and the
> +bandwidth from the SSLBIS for the switch downstream port that is associated
> +with the endpoint is calculated. The final bandwidth is stored in a
> +'struct cxl_perf_ctx' in the xarray indexed by a device pointer. If the
> +endpoint is direct attached to a root port (RP), the device pointer would be a
> +RP device. If the endpoint is behind a switch, the device pointer would be the
an RP 
> +upstream device of the parent switch.
> +
> +At the next stage, the code attempts to walk through one or more switches if
the code walks through
(I doubt it ever fails and if it does that's detail you don't need here)
> +they exist in the topology. For endpoints directly attached to RPs, this
> +step is skipped. If there is another switch upstream, the code takes the min()
> +of the current gathered bandwidth and the upstream link bandwidth. If there's
> +a switch upstream, then the SSLBIS of the upstream switch.
> +
> +Once the topology walk reaches the RP, whether it's direct attached endpoints
> +or walking through the switch(es), cxl_rp_gather_bandwidth() is called. At
> +this point all the bandwidths are aggregated per each host bridge, which is
> +also the index for the resulting xarray.
> +
> +The next step is to take the min() of the per host bridge bandwidth and the
> +bandwidth from the Generic Port (GP). The bandwidths for the GP is retrieved
> +via ACPI tables SRAT/HMAT. The min bandwidth are aggregated under the same
> +ACPI0017 device to form a new xarray.
> +
> +Finally, the cxl_region_update_bandwidth() is called and the aggregated
> +bandwidth from all the members of the last xarray is updated for the
> +access coordinates residing in the cxl region (cxlr) context.

