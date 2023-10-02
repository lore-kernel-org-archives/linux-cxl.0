Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B99E784BD
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Oct 2023 15:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237886AbjJBP2L (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237923AbjJBP2L (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Oct 2023 11:28:11 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE04F99
        for <linux-cxl@vger.kernel.org>; Mon,  2 Oct 2023 08:28:07 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 74BD07A10C3;
        Mon,  2 Oct 2023 15:28:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CFF227A1F30;
        Mon,  2 Oct 2023 15:28:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696260485; a=rsa-sha256;
        cv=none;
        b=pGIQMRjA2O1VkYAPjT0e+q3QX/ypI/gvmo+R9/fLtGsPqNwjEfDGgit6EdM8TjjrQaEdVr
        BMqCTCl+rIUVpX8BaQowt+8TC5lBfIFpnzkqDEtCyWl9QwQVOdC4FQNJUKw+azW8Lm/Z2B
        3QFe/gU3fOyXaaqfLqiSpap7kuGL2pqLq/F/UtsR8+WWdHvfGA8SFZdFhpzEDP6iPQejFP
        m/a/IckhgdVOhY8pah+3jzkyn/F9SbyBrAyIe2n5DCG/N/8L0oBnCRCAM70BIiYcfL2qPq
        8vnddWRdGCnDOqG2ueW60dqrJw2mzNagjy66WNiniHz7aZcG9Nh+4gexYTq5WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1696260485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=+EQuAgV1BeuyIlzTuVFIE+uJuAsTZDucmIlsBv6OiFs=;
        b=62m5ga4QxFX4iX6E2XjfcUkfga7YBtdbj1vj3QEVc0rZWpvHfecaP/0qzv6dWWlaUMGE0O
        GPHu3/zAvKj98XarLdwGBaFDfdAk6wQsDkZceIufpiLwSruPJzXFy4DODRq/9JPMHMTrQC
        sjWaIUXGzlMD9oBrcOk72pKdetgsY3ebIdD4cal24BPIccFVovbLgMbsbqPWXYLpZQ0heM
        kjYE3Ui9/pFHYdvFVahRSLzx/aVtWeE756/fWOzQKggot4bTK0gfjBuIKGhVKTcapmHBAV
        CsQhwBa0lswIscaZqViF9udmy26P6hXyor30plDngwGZU60EiMCHytquPSH8mA==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-xl7vq;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Fearful-Exultant: 6e967f2509641572_1696260486232_956790160
X-MC-Loop-Signature: 1696260486232:1080798612
X-MC-Ingress-Time: 1696260486231
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.122.94.6 (trex/6.9.1);
        Mon, 02 Oct 2023 15:28:06 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4RzlFx33lQz6s;
        Mon,  2 Oct 2023 08:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1696260485;
        bh=+EQuAgV1BeuyIlzTuVFIE+uJuAsTZDucmIlsBv6OiFs=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=JTl4cXVYXeEnqK3r5AsVMS7KTkbkKhIhsxNxjy3cqAp8eIFLQv80gr9TdMjZjsqer
         wbydt3PJlMJEJMW+GYL15XECrG6sdb69fUPjCR7ji9wGTMgMVRAbpnDy42YnQRHKjI
         pgSk1rCcGHgsCvQwV8KlBybVUYo25frcuDD74byhoGzjFR2uUz8KRBmBhWrdbn2xBk
         OEIrLWJGUdiyj7juY9iTtz5A0J0jpIRbNcx2Cr9jOrx1kRp6ngwZN+NF3LKDGZVggm
         Z3nFVeLFqpZGJmBi43Inv2eyfPsAHbe/n5le7z7YvMqHo+UjY7t8Vf/mmOmi/SEX4d
         0B6LlxznK2qYQ==
Date:   Mon, 2 Oct 2023 08:27:53 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com
Subject: Re: [PATCH v2 1/4] cxl/pci: Remove unnecessary device reference
 management in sanitize work
Message-ID: <ovckirfdbuo7wu5cbuky37cqxc66ut3o7him4do6chphxbeixe@7n4dw4wd2dk5>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602897366.904193.9449207727775648546.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <169602897366.904193.9449207727775648546.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 29 Sep 2023, Dan Williams wrote:

>Given that any particular put_device() could be the final put of the
>device, the fact that there are usages of cxlds->dev after
>put_device(cxlds->dev) is a red flag. Drop the reference counting since
>the device is pinned by being registered and will not be unregistered
>without triggering the driver + workqueue to shutdown.
>
>Signed-off-by: Dan Williams <dan.j.williams@intel.com>

If the refcounting is unnecessary, great.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
