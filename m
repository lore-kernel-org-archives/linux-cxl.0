Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA9928506A;
	Thu, 18 Dec 2025 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766086608; cv=none; b=OCzpsYMLsULezKHYu7KICYN+6GpTerdHAiXqO2/F8kkQkHtn89DhWmK2ct88BG17Mxm2cxGvmB0otsXNKMNCHWqLp5zGRBJCLgEpsxxpSZjDQypKuqesC5dXg0ygod1GtMNaasrpVpAE5+8yP3hHURxCh9rMbdlx7m4UoeTJwm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766086608; c=relaxed/simple;
	bh=C38ghsjuQimfuBc48UBJ2Ufk5zJMq7cUdePsSHl094Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=T4UP344u26IzPDblxhTDgDfcY9lKlRd/US6c9dRiqnw9GCcjPEWGKjXUQjviKOdIYfiWH3yldtHwPhxJcfmK/Y9ydhvzsyeUVxf5s1yNu8JwjqOWHfTzLbTFmO9dS+KBFEdKwojXt8tvMjLIUrcFDMhWDkFkUex42WwXF5WixmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qPWHlBCU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qPWHlBCU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=l1xNmQUvehhgwKpE+comx12cHZ+VwWpRWrLfhwMSlHE=; b=qPWHlBCUlrSQp3hLHl0z8x27/t
	IQoMFuTFaMuBZs/ptJnZCEJoAzFc9oNIsKmUg3QMUBIfwpuPDmFGJHxTPx+rmDzZcXLynIRAW0jl9
	GIc0U464AwXK0csxTQkjlWjIWEnsnvp1WkxQcHiRnQxL4c2qx9VId/HEw7PSibRzNN1rkiip3yxzs
	d9U6WdhK43/gaTLHneStKnRTBsSHLW5sVAM64qUdkViJ18UT6z3qIn6cH7Q8b++uYzdw8oIZw/9hA
	affQSaP8TrRjYoleM1heixc6RzGWGEhYL7yHPDsEeTIPdo/OAcMkK0IGZh71l3KTpCRCz/SZu0EpK
	4n+iwcug==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWJnn-000000096PP-0L1q;
	Thu, 18 Dec 2025 19:36:43 +0000
Message-ID: <efc86f10-3255-4132-bae3-8fa6c6dc924b@infradead.org>
Date: Thu, 18 Dec 2025 11:36:41 -0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] Documentation/driver-api/cxl: device hotplug section
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net
References: <20251218170747.1278327-1-gourry@gourry.net>
Content-Language: en-US
In-Reply-To: <20251218170747.1278327-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/18/25 9:07 AM, Gregory Price wrote:
> Describe cxl memory device hotplug implications, in particular how the
> platform CEDT CFMWS must be described to support successful hot-add of
> memory devices.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
> v2: Jonathan's clarifications and diagrams.
> 
>  Documentation/driver-api/cxl/index.rst        |   1 +
>  .../cxl/platform/device-hotplug.rst           | 112 ++++++++++++++++++
>  2 files changed, 113 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/platform/device-hotplug.rst
> 

> diff --git a/Documentation/driver-api/cxl/platform/device-hotplug.rst b/Documentation/driver-api/cxl/platform/device-hotplug.rst
> new file mode 100644
> index 000000000000..617e340bd556
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/device-hotplug.rst
> @@ -0,0 +1,112 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================
> +CXL Device Hotplug
> +==================
> +
> +Device hotplug refers to *physical* hotplug of a device (addition or removal
> +of a physical device from the machine).
> +
> +Hot-Remove
> +==========
> +Hot removal of a device typically requires careful removal of software
> +constructs (memory regions, associated drivers) which manage these devices.
> +
> +Hard-removing a CXL.mem device without carefully tearing down driver stacks
> +is likely to cause the system to machine-check (or at least SIGBUS if memory
> +access is limited to user space).
> +
> +Memory Device Hot-Add
> +=====================
> +A device present at boot will be associated with a CXL Fixed Memory Window
> +reported in :doc:`CEDT<acpi/cedt>`.  That CFMWS may match the size of the
> +device, but the construction of the CEDT CFMWS is platform-defined.
> +
> +Hot-adding a memory device requires this pre-defined (*static*) CFMWS has
> +sufficient space to describe that device.
> +
> +There are a few common scenarios to consider.
> +
> +Single-Endpoint Memory Device Present at Boot
> +---------------------------------------------
> +A device present at boot likely had its capacity reported in the
> +:doc:`CEDT<acpi/cedt>`.  If a device is removed and a new device hotplugged,
> +the capacity of the new device will be limited to the original CFMWS capacity.
> +
> +Adding capacity larger than the original device will cause memory region
> +creation to fail if the region size is greater than the CFMWS size.
> +
> +The CFMWS is *static* and cannot be adjusted.  Platforms which may expect
> +different sized devices to be hotplugged must allocate sufficient CFMWS space
> +*at boot time* to cover all future expected devices.
> +
> +Multi-Endpoint Memory Device Present at Boot
> +--------------------------------------------
> +A hot-plug capable CXL memory device, such as one which presents multiple
> +expanders as a single large-capacity device, should report the maximum
> +*possible* capacity for the device at boot. ::
> +
> +                  HB0
> +                  RP0
> +                   |
> +     [Multi-Endpoint Memory Device]
> +              _____|_____
> +             |          |
> +        [Endpoint0]   [Empty]
> +
> +
> +Limiting the size to the capacity preset at boot will limit hot-add support
> +to replacing capacity that was present at boot.
> +
> +No CXL Device Present at Boot
> +-----------------------------
> +When no CXL memory device is present on boot, some platforms omit the CFMWS
> +in the :doc:`CEDT<acpi/cedt>`.  When this occurs, hot-add is not possible.
> +
> +For a platform to support hot-add of a full memory device, it must allocate
> +a CEDT CFMWS region with sufficient memory capacity to cover all future
> +potentially added capacity.
> +
> +To support memory hotplug directly on the host bridge, or on a switch
> +downstream of the host bridge (but not contained within a CXL memory device),
> +a platform must construct a CEDT CFMWS at boot with sufficient resources to
> +support the max possible (or expected) hotplug memory capacity. ::
> +
> +         HB0                 HB1
> +      RP0    RP1             RP2
> +       |      |               |
> +     Empty  Empty            USP
> +                      ________|________
> +                      |    |    |     |
> +                     DSP  DSP  DSP   DSP
> +                      |    |    |    |
> +                         All  Empty
> +
> +For example, a BIOS/EFI may expose an option to configure a CEDT CFMWS with
> +a pre-configured amount of memory capacity (per host bridge, or host bridge
> +interleave set), even if no device is attached to Root Ports or Downstream
> +Ports at boot (as depicted in the figure above).
> +
> +
> +Interleave Sets
> +===============
> +
> +Host Bridge Interleave
> +----------------------
> +Host-bridge interleaved memory regions are defined *statically* in the
> +:doc:`CEDT<acpi/cedt>`.  To apply cross-host-bridge interleave, a CFMWS entry
> +describing that interleave must have been provided *at boot*.  Hotplugged
> +devices cannot add host-bridge interleave capabilities at hotplug time.
> +
> +See the :doc:`Flexible CEDT Configuration<example-configurations/flexible>`
> +example to see how a platform can provide this kind of flexibility regarding
> +hotplugged memory devices.  BIOS/EFI software should consider options to
> +present flexible CEDT configurations with hotplug support.
> +
> +HDM Interleave
> +--------------
> +Decoder-applied interleave can flexibly handle hotplugged devices, as decoders
> +can be re-programmed after hotplug.
> +
> +To add or remove a device to/from an existing HDM-applied interleaved region,
> +that region must be torn down an re-created.

                                 ^s/an/and/

and one note: There are several places where you use one asterisk for emphasis,
e.g., *statically*. This means <italic> in Sphinx/ReST. If you happen
to mean/want bold, then use **bold text** (double asterisks).

Otherwise it LGTM. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

