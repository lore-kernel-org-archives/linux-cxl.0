Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA28C352A1
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Dec 2022 17:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiLGRCC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Dec 2022 12:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiLGRBn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Dec 2022 12:01:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADF46933A
        for <linux-cxl@vger.kernel.org>; Wed,  7 Dec 2022 09:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sNVAz8HJKuniDX2Lh4zY50/UfRRyVJBkUQA1uPdoNWY=; b=rsPuKf3mmfc3biYKCbGjSuJjjv
        qZTAwuDCcxJqe2mRLRWUzmISRkEBd5YtalN38LQYeykMZEPEWrlPSuO75A9RXzRydgGW6KS2c+NA5
        qcKngztKS93NJZo6Aknzzn0k71d6VFwWrPzmi2YpOTNc9eOZO7CSYwERVJH3sy5rlqOPKFQUeAkwJ
        1ge1Hll/7WjKmNZj+YYdYFAxV9V9k+hNtUGLho58LvJ9T0gCINbDRYKii37U9S0qBpvSjraltJDlK
        MM++1jBtusFNcpdfnoUf5zoS6uKIxNBieIgd36sbpIoW+teZU/s2gDXNNkx7Qgz+xrB8Lzy/kcvD9
        ERioBVxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2xnh-0075NF-3S; Wed, 07 Dec 2022 17:01:41 +0000
Date:   Wed, 7 Dec 2022 09:01:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/pci: Remove endian confusion
Message-ID: <Y5DG9X4270iVaRm4@infradead.org>
References: <167030092025.4045167.10651070153523351093.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167030092025.4045167.10651070153523351093.stgit@dwillia2-xfh.jf.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Dec 05, 2022 at 08:28:40PM -0800, Dan Williams wrote:
> -	status = le32_to_cpu((__force __le32)readl(addr));
> +	status = readl(addr);

Those force casts should have been a giant warning flag..
