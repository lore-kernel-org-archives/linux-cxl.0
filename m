Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C68C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Mar 2022 21:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiCQVFS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Mar 2022 17:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiCQVFS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Mar 2022 17:05:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8935171799
        for <linux-cxl@vger.kernel.org>; Thu, 17 Mar 2022 14:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647551040; x=1679087040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aqLKb0lzeehIgj2n+Ushux/OJw3chaW0zzjeh7+X/JE=;
  b=JN6R8eZiX3Ovko/pQpI+4IK35yWEkW7aor4XDRfZj610zbsS6V0iyT1e
   ISCxNo7KysIVRUj/LPl5ss5oSDk3fNgA8cTfUFcMY9Q17UTqz6rlJMpjX
   xV07nTLYjKLaH9ll2OT6S6GTRn29ktAmnIlrguisBiAbrzTrBYQPndk1n
   MveFQnM/oU70hvbw0bNUPe5MufvqpLZNco/2tGEP0MUttvaRG5dNLBSMX
   CpgllAeraXAdLSdYb2Qmm+f58Oo+7SdiG7ernkrDousqBczI2A6YOsfQC
   lXs8I43s21MgtKsZ97EQ0/ATJ9InOM0dlzsf4uEvSBdwLTqMKmCAQ3P6K
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="237596580"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="237596580"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 14:04:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="614130522"
Received: from dshkut-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.229])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 14:04:00 -0700
Date:   Thu, 17 Mar 2022 14:03:53 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH 0/7] Revamped region creation
Message-ID: <20220317210353.2lye4orffr6rqu4v@intel.com>
References: <20220316230303.1813397-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316230303.1813397-1-ben.widawsky@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-03-16 16:02:56, Ben Widawsky wrote:
> From: Ben Widawsky <ben@bwidawsk.net>
> 
> I will be on vacation all of next week so I'm trying to get this out now, even
> though I still need to go over the locking and lifetimes. I'm certain there are
> still issues there. I did want to start the discussion sooner rather than later
> around the ABI changes.
> 
> The major changes from this series are:
> - disambiguation of decoder types
> - endpoint decoders size and volatility must be set
> - regions are comprised of decoders instead of devices
> - device physical address space is now managed

Dan/all, I used gen_pool API to manage the device's address space. When I
originally authored the patches, I was under the impression that HDM decoders
could be sparsely enabled [1], which leads to the device physical address space
being sparsely populated. As it turns out, this is explicitly disallowed
(8.2.5.12.20). However, I need /some/ way to manage address space, and on third
thought, maybe it's worth it to just leave the gen_pool usage as is.

What are your thoughts? I think the resource APIs are a little klunky given that
we may not yet have sysram mapping for the HDM decoders in the current
programming model. Ranges are possibly usable. gen_pool provides a lot of
flexibility, but it is more complex (but the code is written).

[1]: Practically speaking, decoders can be sparsely enabled. If you set base ==
limit for a decoder it will decode 0 address space. This trick might be nice to
use later.
