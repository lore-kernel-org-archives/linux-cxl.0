Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3713570C6;
	Thu, 18 Dec 2025 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766071586; cv=none; b=LfMlggbKh0xcJWltUU6KwgD0QvYxkLMiwNJ11vw0APu6S3g+15WkXUXBxTZCs7Xl6WTaseKqsBBvmnWHfzpQ3240pgk7AgT3OzDcoctVbf3K7x0H48rBwWxMMtXv6HKbuaFPaznkfiF+8lAcRnzAgkghDUmc/FwCIWdlwAkNE6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766071586; c=relaxed/simple;
	bh=bJgkiMqX9YlHLjTI/Lv0jp6/0k3FJQPRz9YD4GRo2hI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CX7k4iO33Rb8j0J6xDGZOy19t6dtEiNdhaUv55EIOx1+FH/Y2uSKAvyfvsxGlYaXnMBcHrfs195PmB/etePEiGa+V8t4Rovi/rszxSAHnSnlNxUqi50LEzUUR074QW7gw6yBHfL79dMttUQrjaSeL/iMX9TzE0bfYLxnJ/9exnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXDyR1959zHnH7D;
	Thu, 18 Dec 2025 23:25:51 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 879EA40565;
	Thu, 18 Dec 2025 23:26:18 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 18 Dec
 2025 15:26:17 +0000
Date: Thu, 18 Dec 2025 15:26:16 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <corbet@lwn.net>,
	<kernel-team@meta.com>, <alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH] Documentation/driver-api/cxl: device hotplug section
Message-ID: <20251218152616.00005b73@huawei.com>
In-Reply-To: <20251218144636.1232527-1-gourry@gourry.net>
References: <20251218144636.1232527-1-gourry@gourry.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 18 Dec 2025 09:46:36 -0500
Gregory Price <gourry@gourry.net> wrote:

> Describe cxl memory device hotplug implications, in particular how the
> platform CEDT CFMWS must be described to support successful hot-add of
> memory devices.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>

Hi Gregory,

Thanks for drawing this up.

> ---
>  Documentation/driver-api/cxl/index.rst        |  1 +
>  .../cxl/platform/device-hotplug.rst           | 77 +++++++++++++++++++
>  2 files changed, 78 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/platform/device-hotplug.rst
> 
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index c1106a68b67c..5a734988a5af 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -30,6 +30,7 @@ that have impacts on each other.  The docs here break up configurations steps.
>     platform/acpi
>     platform/cdat
>     platform/example-configs
> +   platform/device-hotplug
>  
>  .. toctree::
>     :maxdepth: 2
> diff --git a/Documentation/driver-api/cxl/platform/device-hotplug.rst b/Documentation/driver-api/cxl/platform/device-hotplug.rst
> new file mode 100644
> index 000000000000..9af8988bd47a
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/device-hotplug.rst
> @@ -0,0 +1,77 @@
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
> +Hot-adding a memory device requires that the memory associated with that
> +device fits in a pre-defined (*static*) CXL Fixed Memory Window in the
> +:doc:`CEDT<acpi/cedt>`.
> +
> +There are two basic hot-add scenarios which may occur.
> +
> +Device Present at Boot
> +----------------------
> +A device present at boot likely had its capacity reported in the
> +:doc:`CEDT<acpi/cedt>`.  If a device is removed and a new device hotplugged,

The concept of reporting in CEDT is a little vague. Perhaps expand on that a little
with something like:

A device present at boot will be associated with a CFMWS reported in
@doc:`CEDT<acpi/cedt>` and that CFMWS may match the size of the device.

> +the capacity of the new device will be limited to the original CFMWS capacity.
> +
> +Adding a device larger than the original device will cause memory region
> +creation to fail if the region size is greater than the CFMWS size.

Adding capacity larger than the original device
(can add a subset of the new device capacity)
> +
> +The CFMWS is *static* and cannot be adjusted.  Platforms which may expect
> +different sized devices to be hotplugged must allocate sufficient CFMWS space
> +*at boot time* to cover all future expected devices.
> +
> +No CXL Device Present at Boot
> +-----------------------------
> +When no CXL device is present on boot, most platforms omit the CFMWS in the
> +:doc:`CEDT<acpi/cedt>`.  When this occurs, hot-add is not possible.

Relax to 'some platforms'

Just to future proof the doc for when people start mostly doing the sensible thing.

> +
> +For a platform to support hot-add of a memory device, it must allocate a
For a platofmr to support hot-add of a full memory device
(see above for partial capacity being fine)

> +CEDT CFMWS region with sufficient memory capacity to cover all future
> +potentially added capacity.
> +
> +Switches in the fabric should report the max possible memory capacity
> +expected to be hot-added so that platform software may construct the
> +appropriately sized CFMWS.

How do switches report this? I don't think they can as it really has nothing
to do with the switch beyond maybe how many DSPs it has (which incidentally
is what is used to work out space for PCI HP where the code divides up space
left over space between HP DSPs.).

Obviously this excludes the weird switches that are out there than pretend
to be a single memory device as those are not switches at all as far
as Linux is concerned.

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
> +hotplugged memory devices.
> +
> +Platform vendors should work with switch vendors to work out how this
> +HPA space reservation should work when one or more interleave options are
> +intended to be presented to a host.

Same as above. Nothing to do with switches as far as I understand things
beyond them providing fan out. So if you have
       HB0          HB1
    RP0 RP1         RP2
     |   |           | 
   Empty Empty      USP
              _______|_______
             |    |   |     |
            DSP  DSP  DSP   DSP
             |    |   |     |
                All empty

You might provide more room for devices below HB1 than HB0 if you don't expect
to see switches being hot added.

Jonathan

> +
> +HDM Interleave
> +--------------
> +Decoder-applied interleave can flexibly handle hotplugged devices, as decoders
> +can be re-programmed after hotplug.
> +
> +To add or remove a device to/from an existing HDM-applied interleaved region,
> +that region must be torn down an re-created.

