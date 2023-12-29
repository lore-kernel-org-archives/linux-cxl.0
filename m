Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFD217C4
	for <linux-cxl@vger.kernel.org>; Fri, 29 Dec 2023 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4XdqWiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F76C433C8;
	Fri, 29 Dec 2023 00:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703808256;
	bh=fl4ToNmQ+OSfn8vP0zMMtBXF7+B4qa95KAm3ShtVGJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=O4XdqWiIbk10seg/0JD8sWDTgZUxhJVs06WX3kLaLf/FtQnrIOlUW5R0c/puJq3zS
	 PnsEwwKF56T0PJt1iCtGZp3y0lCPe4DjKEl3YOLyY9iaeq46cC7eMPxVfX4X/OxUHr
	 LIqLh6nO/GSLD1PfManfXWfKJaFwQ6ZwytkMJm1u0ovcZ44Oi9qmmL30qb2f9Lf+fD
	 yqHf28o7BPHOSbNet2vp5POlFfSP2156APocDdOT20zgTY8/b3xSvDjP1xSjWLL0kd
	 bcWzTQR0bfrQN37nxm2X4Xp00hMdrqG3RJ+EGlsW/LosF7AuGgetq2w7zs6yuGXM/0
	 fPMIxh3l9HoJg==
Date: Thu, 28 Dec 2023 18:04:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Len Brown <lenb@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	dave@stgolabs.net
Subject: Re: [PATCH v15 00/19] cxl: Add support for QTG ID retrieval for CXL
 subsystem
Message-ID: <20231229000414.GA1559983@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>

On Thu, Dec 21, 2023 at 03:02:25PM -0700, Dave Jiang wrote:
> v15:
> - Update the hmat generic targets via hmat_update_target_attrs() to retain the best
>   performance numbers from HMAT table.
> - Refactor qos_class valid checks to simplify (Jonathan)

One of these versions apparently rebased to v6.7-rc5.

> v14:
> - Fix 0day issue with fw_table usage (Dan)
> - Move all DSMAS processing local to core/cdat.c (Dan)
> - Change get_qos_class() to qos_class() (Dan)
> - Fix perf entry allocation lifetime (Dan)
> - Rename perf_prop_entry to cxl_dpa_perf (Dan)
> - Cleanup gotos using DEFINE_FREE() (Dan)
> - Move qos computation before regions arrive. (Dan)
> - Drop unmatched perf list (Dan)
> - Add target_lock locking for retrieving genport coordinates (Dan)
> 
> v13:
> - Convert temp dsmas list to xarray, optimize DSLBIS matching (Dan)
> - Add a cxl_test fix for mock ACPI cxl host bridge UID.
> 
> v12:
> - Tested on hardware
> - Rebased to v6.7-rc1
> ...

>       lib/firmware_table: tables: Add CDAT table parsing support
>       base/node / acpi: Change 'node_hmem_attrs' to 'access_coordinates'
>       acpi: numa: Create enum for memory_target access coordinates indexing
>       acpi: numa: Add genport target allocation to the HMAT parsing
>       acpi: Break out nesting for hmat_parse_locality()
>       acpi: numa: Add setting of generic port system locality attributes
>       acpi: numa: Add helper function to retrieve the performance attributes

Drive-by comment since this series isn't for me, but "acpi:" and
"acpi: numa:" are new prefix styles that don't match the drivers/acpi/
history.  It looks nice in *this* series, but not quite as nice in the
future drivers/acpi history.

>       cxl: Add callback to parse the DSMAS subtables from CDAT
>       cxl: Add callback to parse the DSLBIS subtable from CDAT
>       cxl: Add callback to parse the SSLBIS subtable from CDAT
>       cxl: Add support for _DSM Function for retrieving QTG ID
>       cxl: Calculate and store PCI link latency for the downstream ports
>       tools/testing/cxl: Add hostbridge UID string for cxl_test mock hb devices
>       cxl: Store the access coordinates for the generic ports
>       cxl: Add helper function that calculate performance data for downstream ports
>       cxl: Compute the entire CXL path latency and bandwidth data
>       cxl: Store QTG IDs and related info to the CXL memory device context
>       cxl: Export sysfs attributes for memory device QoS class
>       cxl: Check qos_class validity on memdev probe
> 
> 
>  Documentation/ABI/testing/sysfs-bus-cxl |  34 ++
>  drivers/acpi/numa/hmat.c                | 193 +++++++--
>  drivers/acpi/tables.c                   |   5 +-
