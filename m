Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BD0E7F126
	for <linux-cxl@archiver.kernel.org>; Tue, 26 Sep 2023 20:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjIZUXw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 26 Sep 2023 16:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjIZUXw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 26 Sep 2023 16:23:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E675C11D
        for <linux-cxl@vger.kernel.org>; Tue, 26 Sep 2023 13:23:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444A4C433C8;
        Tue, 26 Sep 2023 20:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695759825;
        bh=QFHLMTjVfFoODm26ZFIrHvVeOcyujk2tTFyQNC/M/Rg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MjWHv8j98eTEfeoTeUy6oOaMJVr3ilIAfVIRdA/XlQtKImfw6+BlT13Cebwh1AZq7
         Z1cukgLGqIQBOFgcFKxLfjCXvLRIA+lo/ZuZWoEZD6XFCmghZDLsi8xodo8TJKDvqJ
         Ecg4q/yBH9zCbSq7+Gx4CEy5CWb3VImtiGRzlaxUmfg80rQA9KVbBR0UiaZrHoFKDg
         O+jeagO9b4v3hGOfbDf2pkBW9Bj6hXa2AWdd4FDNOJ39lFwAs8t/j6aoF3RmNHR2LG
         D40VRWPh4ecLYYWWFvkZchGRcgxU+pZola6qKLXaczLjGr1KOtThzdqYikjRKcUUBO
         f6RwzRBqgcLjQ==
Date:   Tue, 26 Sep 2023 15:23:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Cheatham <Benjamin.Cheatham@amd.com>
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        bhelgaas@google.com, yazen.ghannam@amd.com
Subject: Re: [PATCH v5 1/3] CXL, PCIE: Add cxl_rcrb_addr file to dport_dev
Message-ID: <20230926202343.GA419574@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925200127.504256-2-Benjamin.Cheatham@amd.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 25, 2023 at 03:01:25PM -0500, Ben Cheatham wrote:
> Add cxl_rcrb_addr to the dport_dev (normally represented by a pcie
> device) for CXL RCH root ports. The file will print the RCRB base
> MMIO address of the root port when read and will be used by
> users looking to inject CXL EINJ error types for RCH hosts.

I guess this is talking about a sysfs file?  If so, maybe mention that
explicitly in the subject and commit log.

I don't know how you decided to capitalize CXL initialisms and not
"pcie", but I usually use "PCIe".  

> +static struct cxl_port *cxl_root;
> +
> +void set_cxl_root(struct cxl_port *root_port)
> +{
> +	cxl_root = root_port;
> +}

Is there always at most one cxl_root?  Seems worth a one-line comment
at the static data item, since in the world of devices, data is
usually in a per-device struct, not in a single static item.

> @@ -1021,6 +1074,11 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> +	rc = sysfs_create_group(&dport_dev->kobj, &cxl_rcrb_addr_group);
> +	if (rc)
> +		dev_dbg(dport_dev, "Couldn't create cxl_rcrb_addr group: %d\n",
> +			rc);

Is there any way to create this with an attribute group that the sysfs
infrastructure adds automatically?  I'm not suggesting you have a race
condition here, but using the sysfs infrastructure avoids a lot of
potential problems.

Bjorn
