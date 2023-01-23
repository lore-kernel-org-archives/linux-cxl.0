Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2AFC05027
	for <linux-cxl@archiver.kernel.org>; Mon, 23 Jan 2023 18:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjAWSa6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 13:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjAWSaa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 13:30:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B1B33460
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 10:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cOCSRVdqekYprNehiZNEuWVYwgaEtGGYED6w5xq8pgA=; b=XJLiN7egOmdD3hx267pIKRa7aK
        KToRBpyuItPbTLxa7qvz0OGJ9k/bGauTlPF5L42XsaZtHnSN1NxrqogpkOXHEoFWHpJX6R57y/JJH
        DUov2GsLelX4pguRfseyPdH7LUoEMFsOUw8EPu+3bm2wD6/oIvKQYMjvz+PTsJkQlv9nWEira8uym
        ukdEibvm20k5Ph+M2HKYqPU5TshbBFGmK5QnsZd/QUYGvFBrqmF8cwMrJivET/jlXjDhw2GliltgQ
        59uLwV3eYfIyBukdTC+teFbNWWM7rLvfTL9YN1S5py5gqttItOykrf5vfkMCpT2JQqWgj0hy0oI09
        eUt8ERUw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK1Zp-004ROg-0n; Mon, 23 Jan 2023 18:29:53 +0000
Date:   Mon, 23 Jan 2023 18:29:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Adam Manzanares <a.manzanares@samsung.com>
Cc:     David Rientjes <rientjes@google.com>,
        "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Duen-wen Hsiao <duenwen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Fan Ni <fan.ni@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] Session for CXL memory
Message-ID: <Y87SIJm4XLBAmiIY@casper.infradead.org>
References: <F75E3DE0-CDF2-407A-9AF7-8EAE1D177559@bytedance.com>
 <38D49DA9-3C57-4951-8CBA-5D2BB0C40D9C@bytedance.com>
 <CGME20230123055124uscas1p24ec9bf64b225fa5d943dd94ff70311ba@uscas1p2.samsung.com>
 <dd0d92fd-51dc-f5ac-26f9-7446118d654e@google.com>
 <20230123174553.GA341216@bgt-140510-bm01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123174553.GA341216@bgt-140510-bm01>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 23, 2023 at 05:46:00PM +0000, Adam Manzanares wrote:
> The session about DCDs at Plumbers comes to mind here. In addition, I think this

What's a DCD?
