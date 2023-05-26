Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC169C77B7A
	for <linux-cxl@archiver.kernel.org>; Fri, 26 May 2023 04:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjEZEPS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 May 2023 00:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjEZEPR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 May 2023 00:15:17 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDC313D
        for <linux-cxl@vger.kernel.org>; Thu, 25 May 2023 21:15:15 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id AE06B541F79;
        Fri, 26 May 2023 04:15:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a281.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2F3CA542026;
        Fri, 26 May 2023 04:15:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1685074511; a=rsa-sha256;
        cv=none;
        b=TADCOuul5wWTefTHb6BV6RuFxH2oHXibODq0Ybeic+PqauSMa53F9a4deYo79NS1wL88jV
        I4eD/7LxJNjzf9tBoFNtbltgxn1v6AufUIo7fZGbzxeJauajIPkPd1gzjUIOMFUcZZ9Dl2
        LtK7k+Tc8dPVFTrSKGBGKB69SKMzLE5g8oSlbbQdBibNkJFsU4XBu1E/7IuBldfJWADqRR
        P96RKJmYPu8m6EE0nfXqsvrT1xipANdBs0yNj7SIEVKuFHxv1DfLsyJ3KJ1nSbv9nQC7D5
        ur+ECWxcR4GzP35SXwNrCCn/Dr3TG5eIVIWRCAmO/k5c5nU3SpzyQhtTyIg4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1685074511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=jpA+lkeiJSp/D4IRsNpkzyj1QsDImJZjZoLlddsidN0=;
        b=ZSIVL53kM8FGZkeTVV8WwBXMHC1Yj19w6vTVdVs3muyl93AVFqpLXoF/5YdY7OycjMceM8
        HENlozR5XSb9KicUqVsyNdnMWncoNdjhDKfJW+bp7Bom53yAd61QAzLcPM9pN9QKrwr+aK
        Et34cXFKIYMCykhqeWcb1QpryebAdgu1Ly74Pxr8P918hNphNA8hFi/gwhQN7pjdjcPIY6
        4vzn/b1RDhk3CQjZWGt9zmM4ghhuA0DHya3BEe27F24RJ3+/glaOFvKfU3TGzG654CEnj0
        wOoAGdo9PSsENvGPbkAApepAc7NUys1PFbHKu0HlNue45bSVZBWzu9WPDoh2Ng==
ARC-Authentication-Results: i=1;
        rspamd-7d4b855556-jhj4v;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Towering-Relation: 2855c7b735c9481d_1685074511473_872755523
X-MC-Loop-Signature: 1685074511473:1304852130
X-MC-Ingress-Time: 1685074511473
Received: from pdx1-sub0-mail-a281.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.217.250 (trex/6.8.1);
        Fri, 26 May 2023 04:15:11 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a281.dreamhost.com (Postfix) with ESMTPSA id 4QSBR23kqMzCV;
        Thu, 25 May 2023 21:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1685074511;
        bh=jpA+lkeiJSp/D4IRsNpkzyj1QsDImJZjZoLlddsidN0=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=crPRuil4se7mHEpjO/dIf6W8GTEj5frYIdmA00FHZs3WcqKF9I3MPLkxIH2Kj1CGy
         AV2D23gsZ8fvd7Kxt0wSzrBvZwH7Qm4RHbHUd4VjJh0USq70d/pYl3ySLSXCnL4UBy
         Fr3c5Id2EpUC+INZhKyFqu8aK0uF0GvLJCmEQ4EiSrZvL6+3XzbRGgBofV8dRY2hLm
         tmWdP3v/MG0LHSXdMKv2RcnVxghWSsZnA3Sx1ILXwefDXN/oBJi5h3jPq8V1O9D2tO
         jZUCXA5mUEEnSMdjV8b4Mdjp/DYX44Rbd/NHfnteMCQGagaSOdX3rNQuDaMHUMOiQ+
         lSFIXnZuWUInQ==
Date:   Thu, 25 May 2023 20:41:32 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/6] cxl/mem: Wire up Sanitation support
Message-ID: <2rbjiulpjgpl6i4ilwbvndfteciagp72r6fkxlqtcik3t6kr4x@5jka73uukm7w>
References: <20230526033344.17167-1-dave@stgolabs.net>
 <20230526033344.17167-4-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230526033344.17167-4-dave@stgolabs.net>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 25 May 2023, Davidlohr Bueso wrote:

>Implement support for CXL 3.0 8.2.9.8.5.1 Sanitize. This is done by
>adding a security/sanitize' memdev sysfs file, which is poll(2)-capable
>for completion. Unlike all other background commands, this is the
>only operation that is special and monopolizes the device for long
>periods of time.

As becomes obvious in the code, this paragraph actually should have
been updated: the pollable/read file for the status of sanitation
is the security/state.

Thanks,
Davidlohr
