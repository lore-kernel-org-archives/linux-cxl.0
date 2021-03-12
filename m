Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4462C433E0
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Mar 2021 00:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7442964F8E
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Mar 2021 00:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhCLApO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Mar 2021 19:45:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:62597 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhCLAoy (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 11 Mar 2021 19:44:54 -0500
IronPort-SDR: lB6OHaOnumwSOeUGRN49dDkBM2Rc6PpaqYXP1/pKTAmP9X010hISf71u9n1Irl3eI2GXzzZW13
 MH5T7Hef5MWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="185407225"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="185407225"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 16:44:51 -0800
IronPort-SDR: UogMbQPTczuhdA/JiNRH8wqwYFeLI2LaO/EpSafgYb1W5Z4ondRIgJ99imWwom6PYLU+31uCPl
 5IdWZsr/mAlg==
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="410822820"
Received: from askassar-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.143.84])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 16:44:51 -0800
Date:   Thu, 11 Mar 2021 16:44:49 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Raj Vishwanathan <raj.vishwanathan@gmail.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: Testing CXl with qemu and Linux
Message-ID: <20210312004449.akcgmidgyupzqbyn@intel.com>
References: <CA+-5cKfDiDDG6zpnDSg12a=JPD8-FTypi9qA9qdr_CRnkrFuHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-5cKfDiDDG6zpnDSg12a=JPD8-FTypi9qA9qdr_CRnkrFuHg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-03-08 15:33:49, Raj Vishwanathan wrote:
> Raj Vishwanathan <raj.vishwanathan@gmail.com>
> 1:55 PM (1 hour ago)
> to linux-cxl
> 
> I am trying to setup and take a look at an system with CXL enabled
> 
> 1. I downloaded and installed linux.5.11 + CXL patches on a regular qemu system
> 2. I built qemu using Ben Widawsky's CXL-2.0 branch ( I see that there
> is a 2.0v4 tree)
> 3. I also built ndactl  from 2.0v2 branch
> 
> From what I understand, I use the ndactl to create a  memory namespace
> and I use this in the qemu command line to start. Given this and the
> Linux having CXL support  I should be able to see the CXL.mem device
> with lspci. Correct me if I am completely messed up.
> 
> I am not able to create the memory namespace with ndctl
> 
> I tried with
> 
> "./ndctl  create-namespace -t pmem -m raw -n mem0 -v -s 268435456" and
> it fails with
> 
> "failed to create namespace: No such device or address"
> 
> Is there a step by step direction of how to test CXL on Linux? I can
> document this process if someone can describe where am I making a
> mistake
> 
> Raj

Aside from command errors, for which I'm not the expert...

The cxl command will be used to control CXL devices, not ndctl. Nothing other
than sending commands to the CXL device are actually hooked in in any of the:
application, kernel. QEMU has minimal support which may need more and I will be
looking into that.
