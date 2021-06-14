Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4DDC2B9F4
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Jun 2021 16:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726FE613CC
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Jun 2021 16:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhFNQOZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Jun 2021 12:14:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:30186 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234511AbhFNQOZ (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 14 Jun 2021 12:14:25 -0400
IronPort-SDR: snW+WHyilHombKLXhlTvCDw+PROAXxHNIkcQdrQjHgBRr0poM0l/x+1lmxEfPnbMLbSbleV2qO
 bbUlL9CHgbCQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="227292990"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="227292990"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 09:12:17 -0700
IronPort-SDR: B/34aeVrpLoiBpjHsvv/+FKtvOlRAi0GlNLcUpmlujYa+7k9XAiywluQHzIfxuS3JkxqnOe5B0
 xFwpzNf8rASg==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="553410273"
Received: from smothe-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.143.124])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 09:12:17 -0700
Date:   Mon, 14 Jun 2021 09:12:15 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH 2/4] cxl/region: Create attribute structure / verify
Message-ID: <20210614161215.eae4ss7hgwoag27m@intel.com>
References: <20210610185725.897541-1-ben.widawsky@intel.com>
 <20210610185725.897541-3-ben.widawsky@intel.com>
 <CAPcyv4hpxbnvGVQAc15RwGyu1XH8JyiBs8prBG8Rx2wkL3=MpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hpxbnvGVQAc15RwGyu1XH8JyiBs8prBG8Rx2wkL3=MpQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-06-11 17:59:15, Dan Williams wrote:
> On Thu, Jun 10, 2021 at 11:57 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > Introduce a verification mechanism for a region. Regions have complex
> > configuration requirements and it is beneficial to provide a way to
> > verify the constraints are met before trying to bind. Primarily it adds
> > ABI to inform userspace of more detailed information about what failed
> > rather than the limited choices of errno at bind time.
> 
> If you want to give userspace more data about an internal process
> that's a TRACE_EVENT().

Addressed this in the other email...

> 
> > It's important to point out that a verified region can still fail to
> > bind, but the first step in binding will be to run the same verification
> > algorithm.
> 
> I don't see this point of giving userspace a racy / less accurate
> answer than the bind result.

Hopefully I didn't forget to mention that verify() would be an optional call
from userspace. Perhaps making it debugfs makes more sense?
