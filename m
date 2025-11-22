Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E204186294;
	Sat, 22 Nov 2025 00:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772578; cv=none; b=f/I9WGEOcaLsQje8hSCjnPovnhP6OJ/gp3M98gcaSD+wwcF9sSjKsQzXVpBRa09f45riVhdTsHF5b3M/6ilNdRT9VBTTAFQuU1DJHhzEZKcQ1P1hoqU2sSeNkmu5RJBEgcoP8A3RqOXN5hAPbAKxeta7mAeoaVrL2/K9IrI7EWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772578; c=relaxed/simple;
	bh=xdPTRstpZiNdC6F5LAofVXhLuMZp09YFbRvr/iYOMo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RW+7xP/MDYFwqhu09W+x8IJkVPzMNz3nPbwQMiN7k99JWZqvN8y5KFPYo9ffWYEnqkyFUrcNL8dtPI941eNqmACOdFT/OU75gVtCN9cXNDefHebbGn8o27JQu1aK/YqhVW6cqywm7HVrgnwfZzkq54yfRRErI5tgfLQk8xeRrlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Up+OkTo+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Up+OkTo+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0T7Z0U2cyAkgLHUqKlE8zMZnmB56oi5XByNJfhjEjyM=; b=Up+OkTo+TjoRW3MYpLxr9IX8s7
	ltLKcZffvtVngI1jJ7cx93M/7+KLmIueZLiQDYWaJI2us+YfwdjOfX19HGekOPWCXaaAPYhF7vOFm
	X8USUKDLj1lW7iIqTxpsX7mfQW3/kbbIBTwigRUX20Pmh/LXbRrFDNGhTV/ZVzFQcRO5/O6rkyTDt
	YVtD6f0fs/FaM/UeDb+OkHvl1PyNWA1Dv6in29yWQ9rgs9gT5ngiyzKeM+HjoL8n5ZzNIPxQsyYyG
	g0BJuIF/oXJ8twneo5g1R5lbaNAMhyBZEkcr8/UMSeNuBVZiw+fxEecpC0ELcBNNzro7tuYmDy7NJ
	4IjSXz8A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMbog-000000096ms-1sqZ;
	Sat, 22 Nov 2025 00:49:30 +0000
Message-ID: <bb1ae2da-99d4-4d56-8886-06820f923aad@infradead.org>
Date: Fri, 21 Nov 2025 16:49:29 -0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] Documentation/driver-api/cxl: ACPI PRM Address
 Translation Support and AMD Zen5 enablement
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 linux-doc@vger.kernel.org
References: <20251121121655.338491-1-rrichter@amd.com>
 <20251121121655.338491-2-rrichter@amd.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251121121655.338491-2-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/21/25 4:16 AM, Robert Richter wrote:
> This adds a convetion document for the following patch series:
> 

              convention

>  [v7,00/11] cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
>  https://patchwork.kernel.org/project/cxl/cover/20251114213931.30754-1-rrichter@amd.com/
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  Documentation/driver-api/cxl/conventions.rst  |   1 +
>  .../driver-api/cxl/conventions/cxl-atl.rst    | 175 ++++++++++++++++++
>  2 files changed, 176 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/conventions/cxl-atl.rst
> 


> diff --git a/Documentation/driver-api/cxl/conventions/cxl-atl.rst b/Documentation/driver-api/cxl/conventions/cxl-atl.rst
> new file mode 100644
> index 000000000000..9c14856e1782
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/conventions/cxl-atl.rst
> @@ -0,0 +1,175 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
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
> +Host Bridge. The HPA ranges of an CFMWS may include addresses that are

                               of a

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
> +physical memory. Devices have an own memory space and can be

                            have their own
?

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
> +This is esp. important to find an endpoint's associated CXL Host

           especially

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
> +  configuration using platform specific address translation methods.

                         platform-specific

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

-- 
~Randy

