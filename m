Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F4528E25
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwdI1X9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42C1C433C7;
	Mon, 16 Oct 2023 16:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697475520;
	bh=dIZhcJoASvapJFl9tgDa99gZEltzX3ODY16io8txCg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DwdI1X9MWrBi6VwskycxqFUH8vYBxYhYchsMVpu2NkLStaFy7liUC4gd2qGXPqrCe
	 tM0z40u4X3y7DNZjEbuI2nKdXCje6ACViz22yeBsLEavm3bLf1B4O18SAJxOeVsrbW
	 aICESkQO4j/8IP2nT8DR09sPFsedJzv4WSzIgaAFo7TyrJXQLc3583pZiPYEQi7v5G
	 VnWGuQHR8pF5ZO6LWkt2LkP3RJL/rUQS5/KTgNgZlvfTDiO8EZqrbbeeN4BJfO5g4j
	 nMY7ZeDW/ouPjZ93GHBx8BIbt8rUxZi8GnZWfCcCuL/qH1LUHK+zSekutDbZzFJ9vH
	 eo6XQiiW5r0Kg==
Date: Mon, 16 Oct 2023 11:58:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linuxarm@huawei.com,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 3/4] PCI: Add PCI_CLASS_SERIAL_CXL_SWITCH_CCI class ID to
 pci_ids.h
Message-ID: <20231016165838.GA1214574@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016125323.18318-4-Jonathan.Cameron@huawei.com>

On Mon, Oct 16, 2023 at 01:53:22PM +0100, Jonathan Cameron wrote:
> This ID is used for CXL Switch Mailbox CCIs.
> Incorporate the Programming Interface in the definition in common
> with similar entries.
> 
> See CXL rev3.0 81.1.3.1 PCI Header Class Code Register

Also PCI Code and ID Assignment r1.15, sec 1.13, which I assume is
definitive since this is a piece of the PCI namespace.

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 5fb3d4c393a9..27d1bac65256 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -128,6 +128,7 @@
>  #define PCI_CLASS_SERIAL_IPMI_SMIC	0x0c0700
>  #define PCI_CLASS_SERIAL_IPMI_KCS	0x0c0701
>  #define PCI_CLASS_SERIAL_IPMI_BT	0x0c0702
> +#define PCI_CLASS_SERIAL_CXL_SWITCH_CCI	0x0c0b00
>  
>  #define PCI_BASE_CLASS_WIRELESS			0x0d
>  #define PCI_CLASS_WIRELESS_RF_CONTROLLER	0x0d10
> -- 
> 2.39.2
> 
