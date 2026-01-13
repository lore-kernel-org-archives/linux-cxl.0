Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD5D2F363E;
	Tue, 13 Jan 2026 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341813; cv=none; b=OvtUy/5Ne2RK5LgO79dDg0wrd2yy0LOiFH3+hUxIy57tbYAfkjwKiCvMek0zmjPC04HcuhxZWaBgnpNUtevQi7AGWOhGq4VO8izAGGlKjtACkS5TQ0eQJbZJlkOmNkPm58utP04gXYl+m9x/N8LjNtU1wH5KFd/0wB/+XkWbpws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341813; c=relaxed/simple;
	bh=p12yju99auB4KokOND0KnW4C4OL6HoaCj4mKdcicZ7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/CaoO0M4Sd26CkFWwyz1VHDPlLcBeMBSpbo1crHaJJqETl9gvONTplm5UPmWSFH9mBuPeonGHeCBTtuDTZwJDuCoFSVFuh4InSuk26PIdEOCyRqzOPPmji5rQRbL48/OXL2uDO0AJDMM3vEn1fG0lxaViO+zkEeYLFDucwtm+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h61bkVTg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h61bkVTg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768341811; x=1799877811;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p12yju99auB4KokOND0KnW4C4OL6HoaCj4mKdcicZ7M=;
  b=h61bkVTgxZy6vtAFO+Dz0d7d842hZ+2WuHpQGGumjv5zK1m9xODVx5Qb
   IBHCNu7SAeBoqRESllOsBnVcJoWuAgW38LKFdUvs7AujS/hB/0FzutQHM
   ms5Dc5mQK/2608DcUwPkuLZQ2KN/yiXbOeICL3NNk4sjwpChSgw8QFO9i
   UCevgrjRxtl8kInKc6Z+/h8ZY1WCTY7pYFp0LaQvTz6LheVP9sRHxhDJF
   lwV3eNdvCZVkoYRL4drgiR320UTkI3er14WK+1HMB5P81/3dF/6/bICpg
   v71ifMRnHnd6YoIveYoI/kvbcmnQOLQFREhCKv5wqhZRIlZRmEErLyCgQ
   g==;
X-CSE-ConnectionGUID: q+2Oj1seRiyeehLSh27kgA==
X-CSE-MsgGUID: 9wxfu7f4SW2Rs1AW2RhvWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="81002691"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="81002691"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 14:03:30 -0800
X-CSE-ConnectionGUID: wQ415eqoTZCqEu1fHdUHnA==
X-CSE-MsgGUID: 9MfCsvQISEqvvbGJjHr4Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="208662697"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.189]) ([10.125.110.189])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 14:03:28 -0800
Message-ID: <cc18931c-8c13-486d-bd70-ffb2ebd9ec93@intel.com>
Date: Tue, 13 Jan 2026 15:03:27 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] Documentation/driver-api/cxl: ACPI PRM Address
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
 linux-doc@vger.kernel.org
References: <20260112111707.794526-1-rrichter@amd.com>
 <20260112111707.794526-3-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260112111707.794526-3-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/12/26 4:16 AM, Robert Richter wrote:
> This adds a convention document for the following patch series:
> 
>  cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
> 
> Version 7 and later:
> 
>  https://lore.kernel.org/linux-cxl/20251114213931.30754-1-rrichter@amd.com/
> 
> Link: https://lore.kernel.org/linux-cxl/20251114213931.30754-1-rrichter@amd.com/
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> v3:
>  * updated link in descriptions and add Link: tag (Jonathan Cameron),
>  * clarified CFMWS and HPA range description (Jonathan Cameron),
>  * use 80 chars line limit (Jonathan Cameron),
>  * added block diagram to illustrate the example address mappings (Dave),
> v2:
>  * updated sob-chain,
>  * spell fix in patch description (Randy),
>  * made small changes as suggested by Randy,
>  * Removed include:: <isonum.txt> line (Jon).
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  Documentation/driver-api/cxl/conventions.rst  |   1 +
>  .../driver-api/cxl/conventions/cxl-atl.rst    | 205 ++++++++++++++++++
>  2 files changed, 206 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/conventions/cxl-atl.rst
> 
> diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
> index 9267a697b2fe..0d2e07279ad9 100644
> --- a/Documentation/driver-api/cxl/conventions.rst
> +++ b/Documentation/driver-api/cxl/conventions.rst
> @@ -14,4 +14,5 @@ same convention.
>     :caption: Contents
>  
>     conventions/cxl-lmh.rst
> +   conventions/cxl-atl.rst
>     conventions/template.rst
> diff --git a/Documentation/driver-api/cxl/conventions/cxl-atl.rst b/Documentation/driver-api/cxl/conventions/cxl-atl.rst
> new file mode 100644
> index 000000000000..69fed0044b52
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/conventions/cxl-atl.rst
> @@ -0,0 +1,205 @@
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
> +The CXL Fixed Memory Window Structures (CFMWS) describe zero or more Host
> +Physical Address (HPA) windows associated with one or more CXL Host Bridges.
> +Each HPA range of a CXL Host Bridge is represented by a CFMWS entry. An HPA
> +range may include addresses currently assigned to CXL.mem devices, or an OS may
> +assign ranges from an address window to a device.
> +
> +Host-managed Device Memory is Device-attached memory that is mapped to system
> +coherent address space and accessible to the Host using standard write-back
> +semantics. The managed address range is configured in the CXL HDM Decoder
> +registers of the device. An HDM Decoder in a device is responsible for
> +converting HPA into DPA by stripping off specific address bits.
> +
> +CXL devices and CXL bridges use the same HPA space. It is common across all
> +components that belong to the same host domain. The view of the address region
> +must be consistent on the CXL.mem path between the Host and the Device.
> +
> +This is described in the current CXL specification (Table 1-1, 3.3.1, 8.2.4.20,
> +9.13.1, 9.18.1.3). [#cxl-spec-3.2]_
> +
> +Depending on the interconnect architecture of the platform, components attached
> +to a host may not share the same host physical address space. Those platforms
> +need address translation to convert an HPA between the host and the attached
> +component, such as a CXL device. The translation mechanism is host-specific and
> +implementation dependent.
> +
> +E.g., x86 AMD platforms use a Data Fabric that manages access to physical
> +memory. Devices have their own memory space and can be configured to use
> +'Normalized addresses' different to System Physical Addresses (SPA). Address
> +translation is needed then. Details are described also under x86 AMD
> +Documentation/admin-guide/RAS/address-translation.rst.
> +
> +Those AMD platforms provide PRM handlers in firmware to perform various types of
> +address translation, including for CXL endpoints. AMD Zen5 systems implement the
> +ACPI PRM CXL Address Translation firmware call. The ACPI PRM handler has a
> +specific GUID to uniquely identify platforms with support of Normalized
> +addressing. This is documented in the ACPI v6.5 Porting Guide, Address
> +Translation - CXL DPA to System Physical Address. [#amd-ppr-58088]_
> +
> +When in Normalized address mode, HDM decoder address ranges must be configured
> +and handled differently. Hardware addresses used in the HDM decoder
> +configurations of an endpoint are not SPA and need to be translated from the
> +endpoint's to its CXL host bridge's address range. This is especially important
> +to find an endpoint's associated CXL Host Bridge and HPA window described in the
> +CFMWS. Also, the interleave decoding is done by the Data Fabric and the endpoint
> +does not perform decoding when converting HPA to DPA. Instead, interleaving is
> +switched off for the endpoint (1 way). Finally, address translation might also
> +be needed to inspect the Endpoint's hardware addresses, such as during
> +profiling, tracing or error handling.
> +
> +For example, with Normalized addressing the HDM decoders could look as
> +following::
> +
> +                          -------------------------------
> +                          | Root Decoder (CFMWS)        |
> +                          | SPA Range: 0x850000000      |
> +                          | Size: 0x8000000000 (512 GB) |
> +                          | Interleave Ways: 1          |
> +                          -------------------------------
> +                                        |
> +                                        v
> +                          -------------------------------
> +                          | Host Bridge Decoder (HDM)   |
> +                          | SPA Range: 0x850000000      |
> +                          | Size: 0x8000000000 (512 GB) |
> +                          | Interleave Ways: 4          |
> +                          | Targets: endpoint5,8,11,13  |
> +                          | Granularity: 256            |
> +                          -------------------------------
> +                                        |
> +           -----------------------------+------------------------------
> +           |                  |                   |                   |
> +           v                  v                   v                   v
> + ------------------- ------------------- ------------------- -------------------
> + | endpoint5       | | endpoint8       | | endpoint11      | | endpoint13      |
> + | decoder5.0      | | decoder8.0      | | decoder11.0     | | decoder13.0     |
> + | PCIe:           | | PCIe:           | | PCIe:           | | PCIe:           |
> + |   0000:e2:00.0  | |   0000:e3:00.0  | |   0000:e4:00.0  | |   0000:e1:00.0  |
> + | DPA:            | | DPA:            | | DPA:            | | DPA:            |
> + |   Start: 0x0    | |   Start: 0x0    | |   Start: 0x0    | |   Start: 0x0    |
> + |   Size:         | |   Size:         | |   Size:         | |   Size:         |
> + |    0x2000000000 | |    0x2000000000 | |    0x2000000000 | |    0x2000000000 |
> + |    (128 GB)     | |    (128 GB)     | |    (128 GB)     | |    (128 GB)     |
> + | Interleaving:   | | Interleaving:   | | Interleaving:   | | Interleaving:   |
> + |   Ways: 1       | |   Ways: 1       | |   Ways: 1       | |   Ways: 1       |
> + |   Gran: 256     | |   Gran: 256     | |   Gran: 256     | |   Gran: 256     |
> + ------------------- ------------------- ------------------- -------------------
> +          |                   |                   |                   |
> +          v                   v                   v                   v
> +         DPA                 DPA                 DPA                 DPA
> +
> +This shows the representation in sysfs:
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
> +Note the endpoint interleaving configurations with a direct mapping (1-way).
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
> +The corresponding CXL host bridge (HDM) decoders and root decoder (CFMWS) show
> +and match with the calculated endpoint mappings:
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
> +* Allow a CXL device to be in a different HPA space other than the host's space.
> +
> +* The platform can use implementation-specific address translation when crossing
> +  memory domains on the CXL.mem path between the Host and the Device.
> +
> +* The kernel (OSPM) determines Endpoint SPA range and interleaving configuration
> +  using platform-specific address translation methods.
> +
> +Benefits of the Change
> +----------------------
> +
> +Without the change, the OSPM may not determine the memory region and Root
> +Decoder of an Endpoint and its corresponding HDM decoder. Region creation would
> +fail. Platforms with a different interconnect architecture would fail to setup
> +and use CXL.
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
> +Add the following paragraph in 8.2.4.20 CXL HDM Decoder Capability Structure of
> +the specification [#cxl-spec-3.2]_ to the end:
> +
> +"A device may use a different HPA space that is not common to other components
> +of the host domain. The platform is responsible for address translation when
> +crossing HPA spaces. The OSPM must determine the interleaving configuration and
> +perform address translation to HPA ranges of the HDM decoders as needed. The
> +translation mechanism is host-specific and implementation dependent."

