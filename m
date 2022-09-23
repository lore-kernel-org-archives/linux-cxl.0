Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87164ECAAD8
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Sep 2022 10:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiIWKvo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Sep 2022 06:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiIWKvJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 23 Sep 2022 06:51:09 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F31131F4F
        for <linux-cxl@vger.kernel.org>; Fri, 23 Sep 2022 03:51:06 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 737157E0B82;
        Fri, 23 Sep 2022 10:51:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a225 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 503677E0C47;
        Fri, 23 Sep 2022 10:51:04 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1663930264; a=rsa-sha256;
        cv=none;
        b=n88g1YlXZBXB8Y+KiAlOPRX2Mmx3zMmgLyxTXXn2FZzlx5z/gPgaCeF2S78ZEv0lnmC3vz
        fpPG+POVQeqK4xZPOwoMYsjMe/ncKZlxe+ll7qWIXUtxI+VOcsIKv1kg1/YW1wTVMxzVXV
        yICsgMdt44D6bNKKCmKtylTaxSVx0OHtKbkvVc2ntBnFkHTvTixHHw6EI22rQW5mqmq91H
        bPCS/hTejzzre8/mjFzzivCi79BWJRkKng4diM4tkYhMKLRQeNlOwOYshJNYtrH5y8vwLW
        of3MpJqYxCzQAPYVfaPwQ/atzFwW+yB6pW+vsWg5++RSFHPz20xL5rkFDMs9fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1663930264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Ie/dxT+MbEVYw2FyLT9+kDoEy97y+gsyEJxiGj8t83g=;
        b=JI1nYgivhdrWehJrR1jYPRBMHX59mCrZp2ImKPauY+zY9rHwd0dyU5PhKHQhrTmlLfyQ2d
        b850lzvtw7tTLe5rpo9bgjFNJ/AiJwnOLitNUf2FJyxNGCVAPRIS4jnsVOx2yXbMfm98Lm
        Sez3qtJs6fYkBcG2d3Wbvvqf5QawLIAk/10fq9htCNJbDLXoWN1GWsy1/S5CqRNaUZPiKL
        BfcjG0B9Wob0h8VutjcHuFCiqqwCclSNK7LyXcp4rZlj4DNl1+NdCx0XXpuC4bV4oKHN3K
        T+ZJvOtylr51d7ayR67qPg48sK+MVFZBj6MPtJzgRg5mBl2jA+yP6flARMJQmQ==
ARC-Authentication-Results: i=1;
        rspamd-75d6d4d78d-m2zbr;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Soft-Abortive: 445758ee7525ae7b_1663930264810_1087246426
X-MC-Loop-Signature: 1663930264810:318372154
X-MC-Ingress-Time: 1663930264809
Received: from pdx1-sub0-mail-a225 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.63.144 (trex/6.7.1);
        Fri, 23 Sep 2022 10:51:04 +0000
Received: from offworld (unknown [185.237.102.49])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a225 (Postfix) with ESMTPSA id 4MYppq6j9jz27;
        Fri, 23 Sep 2022 03:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1663930263;
        bh=Ie/dxT+MbEVYw2FyLT9+kDoEy97y+gsyEJxiGj8t83g=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=O5a/izc5JUvbKwY/3DSWwfY8zYPGxPOAyvLHmAl24GrpEkmVtMDmZO8F1AiPU6SzZ
         jY6lLXuboyw5U+f2NfDzhTj0NNjV+Jqmd6QzFjZ6WGNj+4p7h6rdtV+cHo/Ekn11Vx
         dU5eR1sr6WDlRpjGhLOpMB+9wqpoEQ1Lso8XuxQ2vtldPHMh0Ma69cAeAdlOOfHi3H
         i2aC9x1hsNwhF+WEA8LCFKdw9qQ8a+DH8oAP+SVknI+YLL2TSFB8idvfRieZ6VCg1P
         O5dWe5IMDL/3g3N3L339ImAQ2M/OnIeAQWmExu7vZRol8eLO0PG5AkHe0HtA+KVYQc
         ov2FmfYiLBVEA==
Date:   Fri, 23 Sep 2022 03:31:08 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        dan.j.williams@intel.com, bwidawsk@kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Subject: Re: [PATCH v2 19/19] cxl: add dimm_id support for __nvdimm_create()
Message-ID: <20220923103108.wt62gzebnyovpjjr@offworld>
References: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
 <166377440119.430546.15623409728442106946.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <166377440119.430546.15623409728442106946.stgit@djiang5-desk3.ch.intel.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 21 Sep 2022, Dave Jiang wrote:

>Set the cxlds->serial as the dimm_id to be fed to __nvdimm_create(). The
>security code uses that as the key description for the security key of the
>memory device. The nvdimm unlock code cannot find the respective key
>without the dimm_id.

Maybe I'm being daft but I don't see why cxlds->serial could not just be
used for __nvdimm_create() instead of adding a new member.
