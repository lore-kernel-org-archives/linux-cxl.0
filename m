Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A092FFF95;
	Wed, 10 Dec 2025 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765381475; cv=none; b=CT83ukaTdrjuKDjfdyKzQOJagnAwx3jROhQkZ3Hy67ifhC4ujdWSffN+Z3fG+vQz8mn7ike0KzBJS29wWbV4G0E41ZiTe2LQqghPC9JFGtX7H8sMVZ9sm5Wsa84xgyWmYfl1lIaaZz48KUB8ICqzHqNslURMOc2jpeva8L6ryRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765381475; c=relaxed/simple;
	bh=K7bMQJ8AX7Jzr0xyT5MjUO6Lvd8NVfX+SZWfBLl5w2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5d7SJVoTVMequIuWtGgcke17fCou9jZaLLZDowi0nbEoXQBcsnLlFVItWzmQr2tGHumvpOPJSSxrJF7K4vRyjaF0UOpfPk/8Vd9pFIDx/2otPimsp/z+B/+zFknN4olm7OvWmBq1ZopkbrAhtJqsrjLJVG8kYyMYN3gd4S2Dcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUl9css1; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUl9css1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765381473; x=1796917473;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K7bMQJ8AX7Jzr0xyT5MjUO6Lvd8NVfX+SZWfBLl5w2E=;
  b=UUl9css1qvLCXhHNs/5BrrIxfVYPWiDZpNZ1OLNmbw5W+tAgNyT65B5j
   NgmfujSXkvFHJx4GVs1Lt9hAnA7ykVdi5nnwLq+zj0/E28AVoA8xr9f2y
   69euqWopDNlGIyrUABYzuEhGXle0/hmi+S20oZL1ka5AeGznoCzFmu9bc
   kr8gHe2HqpsZK1dRmAPMaNmzuiZlbqaIZPa8p2a1IM0e+4AAtzrEUkx1z
   w7BI8Vy7UDBzsL1kdk/ZMb504WdYEmZ0Jq5P8o02l9uov1qfMPT9ThRJz
   8iyEL+RVIF0Xu1ig9LWaEBwPMDQJSNZrR4fLtGL5AVN+hUO5ivehcQADX
   A==;
X-CSE-ConnectionGUID: OE9CySUXRnKE+74m1PW31A==
X-CSE-MsgGUID: 296Bd5oETpCaLe1WXigfQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67391089"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="67391089"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 07:44:32 -0800
X-CSE-ConnectionGUID: 5D/Gcgf8S/u1YfTvGJWghg==
X-CSE-MsgGUID: ASTREkokQqiuq9LaRHsZvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="201463819"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.138]) ([10.125.109.138])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 07:44:31 -0800
Message-ID: <a3d725c9-71d8-4bb3-b1b9-6404cbd9eb21@intel.com>
Date: Wed, 10 Dec 2025 08:44:30 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Documentation/driver-api/cxl: ACPI PRM Address
 Translation Support and AMD Zen5 enablement
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
References: <20251209181959.210533-1-rrichter@amd.com>
 <20251209181959.210533-2-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20251209181959.210533-2-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/9/25 11:19 AM, Robert Richter wrote:
> This adds a convention document for the following patch series:
> 
>  cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
> 
> Version 7 and later:
> 
>  https://patchwork.kernel.org/project/cxl/cover/20251114213931.30754-1-rrichter@amd.com/
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>

The content looks good. Would love to see an ascii block diagram showing the relationships of SPA/HPA/DPA in this scenario.

DJ

> ---
> v2:
>  * updated sob-chain,
>  * spell fix in patch description (Randy),
>  * made small changes as suggested by Randy,
>  * Removed include:: <isonum.txt> line (Jon).
> ---
> ---
>  Documentation/driver-api/cxl/conventions.rst  |   1 +
>  .../driver-api/cxl/conventions/cxl-atl.rst    | 174 ++++++++++++++++++
>  2 files changed, 175 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/conventions/cxl-atl.rst
> 
> diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
> index 53f31a229c8d..cf427afac58b 100644
> --- a/Documentation/driver-api/cxl/conventions.rst
> +++ b/Documentation/driver-api/cxl/conventions.rst
> @@ -8,4 +8,5 @@ Compute Express Link: Linux Conventions
>     :caption: Contents
>  
>     conventions/cxl-lmh.rst
> +   conventions/cxl-atl.rst
>     conventions/template.rst
> diff --git a/Documentation/driver-api/cxl/conventions/cxl-atl.rst b/Documentation/driver-api/cxl/conventions/cxl-atl.rst
> new file mode 100644
> index 000000000000..955263dcbb3a
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/conventions/cxl-atl.rst
> @@ -0,0 +1,174 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +ACPI PRM CXL Address Translation
> +================================
> +
> +Document
> +--------
> +
> +CXL Revision 3.2, Version 1.0
> +
> +License
> +-------
> +
> +SPDX-License Identifier: CC-BY-4.0
> +
> +Creator/Contributors
> +--------------------
> +
> +- Robert Richter, AMD
> +
> +Summary of the Change
> +---------------------
> +
> +The CXL Fixed Memory Window Structure (CFMWS) describes zero or more
> +Host Physical Address (HPA) windows that are associated with each CXL
> +Host Bridge. The HPA ranges of a CFMWS may include addresses that are
> +currently assigned to CXL.mem devices, or an OS may assign ranges from
> +an address window to a device.
> +
> +Host-managed Device Memory is Device-attached memory that is mapped to
> +system coherent address space and accessible to the Host using
> +standard write-back semantics. The managed address range is configured
> +in the CXL HDM Decoder registers of the device. An HDM Decoder in a
> +device is responsible for converting HPA into DPA by stripping off
> +specific address bits.
> +
> +CXL devices and CXL bridges use the same HPA space. It is common
> +across all components that belong to the same host domain. The view of
> +the address region must be consistent on the CXL.mem path between the
> +Host and the Device.
> +
> +This is described in the current CXL specification (Table 1-1, 3.3.1,
> +8.2.4.20, 9.13.1, 9.18.1.3). [#cxl-spec-3.2]_
> +
> +Depending on the interconnect architecture of the platform, components
> +attached to a host may not share the same host physical address space.
> +Those platforms need address translation to convert an HPA between the
> +host and the attached component, such as a CXL device. The translation
> +mechanism is host-specific and implementation dependent.
> +
> +E.g., x86 AMD platforms use a Data Fabric that manages access to
> +physical memory. Devices have their own memory space and can be
> +configured to use 'Normalized addresses' different to System Physical
> +Addresses (SPA). Address translation is needed then. Details are
> +described also under x86 AMD
> +Documentation/admin-guide/RAS/address-translation.rst.
> +
> +Those AMD platforms provide PRM handlers in firmware to perform
> +various types of address translation, including for CXL endpoints.
> +AMD Zen5 systems implement the ACPI PRM CXL Address Translation
> +firmware call. The ACPI PRM handler has a specific GUID to uniquely
> +identify platforms with support of Normalized addressing. This is
> +documented in the ACPI v6.5 Porting Guide, Address Translation - CXL
> +DPA to System Physical Address.  [#amd-ppr-58088]_
> +
> +When in Normalized address mode, HDM decoder address ranges must be
> +configured and handled differently. Hardware addresses used in the HDM
> +decoder configurations of an endpoint are not SPA and need to be
> +translated from the endpoint's to its CXL host bridge's address range.
> +This is especially important to find an endpoint's associated CXL Host
> +Bridge and HPA window described in the CFMWS. Also, the interleave
> +decoding is done by the Data Fabric and the endpoint does not perform
> +decoding when converting HPA to DPA. Instead, interleaving is switched
> +off for the endpoint (1 way). Finally, address translation might also
> +be needed to inspect the Endpoint's hardware addresses, such as during
> +profiling, tracing or error handling.
> +
> +For example, with Normalized addressing the HDM decoders could look as
> +following:
> +
> +.. code-block:: none
> +
> + /sys/bus/cxl/devices/endpoint5/decoder5.0/interleave_granularity:256
> + /sys/bus/cxl/devices/endpoint5/decoder5.0/interleave_ways:1
> + /sys/bus/cxl/devices/endpoint5/decoder5.0/size:0x2000000000
> + /sys/bus/cxl/devices/endpoint5/decoder5.0/start:0x0
> + /sys/bus/cxl/devices/endpoint8/decoder8.0/interleave_granularity:256
> + /sys/bus/cxl/devices/endpoint8/decoder8.0/interleave_ways:1
> + /sys/bus/cxl/devices/endpoint8/decoder8.0/size:0x2000000000
> + /sys/bus/cxl/devices/endpoint8/decoder8.0/start:0x0
> + /sys/bus/cxl/devices/endpoint11/decoder11.0/interleave_granularity:256
> + /sys/bus/cxl/devices/endpoint11/decoder11.0/interleave_ways:1
> + /sys/bus/cxl/devices/endpoint11/decoder11.0/size:0x2000000000
> + /sys/bus/cxl/devices/endpoint11/decoder11.0/start:0x0
> + /sys/bus/cxl/devices/endpoint13/decoder13.0/interleave_granularity:256
> + /sys/bus/cxl/devices/endpoint13/decoder13.0/interleave_ways:1
> + /sys/bus/cxl/devices/endpoint13/decoder13.0/size:0x2000000000
> + /sys/bus/cxl/devices/endpoint13/decoder13.0/start:0x0
> +
> +Note the endpoint interleaving configurations with a direct mapping
> +(1-way).
> +
> +With PRM calls, the kernel can determine the following mappings:
> +
> +.. code-block:: none
> +
> + cxl decoder5.0: address mapping found for 0000:e2:00.0 (hpa -> spa):
> +   0x0+0x2000000000 -> 0x850000000+0x8000000000 ways:4 granularity:256
> + cxl decoder8.0: address mapping found for 0000:e3:00.0 (hpa -> spa):
> +   0x0+0x2000000000 -> 0x850000000+0x8000000000 ways:4 granularity:256
> + cxl decoder11.0: address mapping found for 0000:e4:00.0 (hpa -> spa):
> +   0x0+0x2000000000 -> 0x850000000+0x8000000000 ways:4 granularity:256
> + cxl decoder13.0: address mapping found for 0000:e1:00.0 (hpa -> spa):
> +   0x0+0x2000000000 -> 0x850000000+0x8000000000 ways:4 granularity:256
> +
> +The corresponding CXL host bridge (HDM) decoders and root decoder
> +(CFMWS) show and match with the calculated endpoint mappings:
> +
> +.. code-block:: none
> +
> + /sys/bus/cxl/devices/port1/decoder1.0/interleave_granularity:256
> + /sys/bus/cxl/devices/port1/decoder1.0/interleave_ways:4
> + /sys/bus/cxl/devices/port1/decoder1.0/size:0x8000000000
> + /sys/bus/cxl/devices/port1/decoder1.0/start:0x850000000
> + /sys/bus/cxl/devices/port1/decoder1.0/target_list:0,1,2,3
> + /sys/bus/cxl/devices/port1/decoder1.0/target_type:expander
> + /sys/bus/cxl/devices/root0/decoder0.0/interleave_granularity:256
> + /sys/bus/cxl/devices/root0/decoder0.0/interleave_ways:1
> + /sys/bus/cxl/devices/root0/decoder0.0/size:0x8000000000
> + /sys/bus/cxl/devices/root0/decoder0.0/start:0x850000000
> + /sys/bus/cxl/devices/root0/decoder0.0/target_list:7
> +
> +The following changes of the specification are needed:
> +
> +* Allow a CXL device to be in a different HPA space other than the
> +  host's space.
> +
> +* The platform can use implementation-specific address translation
> +  when crossing memory domains on the CXL.mem path between the Host
> +  and the Device.
> +
> +* The kernel (OSPM) determines Endpoint SPA range and interleaving
> +  configuration using platform-specific address translation methods.
> +
> +Benefits of the Change
> +----------------------
> +
> +Without the change, the OSPM may not determine the memory region and
> +Root Decoder of an Endpoint and its corresponding HDM decoder. Region
> +creation would fail. Platforms with a different interconnect
> +architecture would fail to setup and use CXL.
> +
> +References
> +----------
> +
> +.. [#cxl-spec-3.2] Compute Express Link Specification, Revision 3.2, Version 1.0,
> +   https://www.computeexpresslink.org/
> +
> +.. [#amd-ppr-58088] AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh,
> +   ACPI v6.5 Porting Guide, Publication # 58088,
> +   https://www.amd.com/en/search/documentation/hub.html
> +
> +Detailed Description of the Change
> +----------------------------------
> +
> +Add the following paragraph in 8.2.4.20 CXL HDM Decoder Capability
> +Structure of the specification [#cxl-spec-3.2]_ to the end:
> +
> +"A device may use a different HPA space that is not common to other
> +components of the host domain. The platform is responsible for address
> +translation when crossing HPA spaces. The OSPM must determine the
> +interleaving configuration and perform address translation to HPA
> +ranges of the HDM decoders as needed. The translation mechanism is
> +host-specific and implementation dependent."

