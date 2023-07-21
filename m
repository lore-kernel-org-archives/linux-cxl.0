Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AC8C41513
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Jul 2023 17:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjGUR0S (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjGURZh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Jul 2023 13:25:37 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1991C3C20
        for <linux-cxl@vger.kernel.org>; Fri, 21 Jul 2023 10:25:15 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5FADF7A0F2B;
        Fri, 21 Jul 2023 17:25:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BB1977A1B55;
        Fri, 21 Jul 2023 17:25:13 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1689960313; a=rsa-sha256;
        cv=none;
        b=JcoOA9tRxf/+r3XcLn7Qw23TFvYqIAU9/wujURNWi2H6868OAd6XSwiX189+jLCK7C5Y6C
        v0ROA7QwbgShllaXaShxPKp9Vbi82TjtcNJSJxxeUqDaUcnUOyTkFvqF0J8rJHaZmKp3FH
        776bPlXY/xhkIcxnM2thtKaww+bJw9IenbhkXq+rPA+clQjeH8trTlQJt9GfXQbUWXcMUt
        szn7YsmAGdB4PnNUs6Jiic9BmGBNOWzDVtk8jXUJIt6GUkq17D8awvO22TwfP/J1ymFnfy
        WBaiPgtOiRtX9j4v2CGr2dUgP3lUrTo/GpFh7Sjm4aSYPs3y96tnwtStpv9ohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1689960313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=WxKFhBoirXRyWssdgw5SX2lCzWoVUDva6QzZ9rDDwDk=;
        b=njWC0rb+oaVUylZyhevw/PazlVp+UKWlOIBhd0JVy6pcWFs5JcGPRGXsKcUO3UagPbqNSR
        d+iCf12XjdaHQY8Roji5yrgagHYYQrDYjduowzHLvAdV9DLYsoob+GGQ6Ap1FHBZxuoNgB
        U4AW/xjChPAhuVtUE+e0UP/te2CSDVG7LvynHqf8iG/DcgjiYtoWVIwEunpiAcJYSLiJy7
        zxn5w8RMlDmV+/mOuZeHvsx0tgRhT04mW1ppa3Dfdl7L+RUFvUgirO0kwcyOUL/GvlW4tJ
        7FxRDyrJpOoISc3jbhrPRNcSAW/59aEUsSoJnRu/+KOAqJfLXAN6cqg9LJsfyQ==
ARC-Authentication-Results: i=1;
        rspamd-59bd44d99d-r4567;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Supply-Relation: 4ac73ab5712ebf6a_1689960314121_3041654195
X-MC-Loop-Signature: 1689960314121:1350591840
X-MC-Ingress-Time: 1689960314121
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.119.45.107 (trex/6.9.1);
        Fri, 21 Jul 2023 17:25:14 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4R6xJm5SW5zCV;
        Fri, 21 Jul 2023 10:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1689960313;
        bh=WxKFhBoirXRyWssdgw5SX2lCzWoVUDva6QzZ9rDDwDk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=g6OMX21Yvm+e6QK6vXV5lN4NtNAkx2epD0zmsUOreuF2wfjsktOpodDE3/UrrbCj/
         ENl4sa4eQ2tuRS+0Abwd9O1AUZ6uic+/75nHmEzu0yhn8INNylvfnt+MGJDjUNcc4C
         HPPmvhkYYdTufEnbB3isbKSfwJr37H4wKNgTkEG8cPlqGx5rTCf8vGRk3EmqT9mfb6
         V06GieyZ4/tsBCwEKDT3DPqFSLZ+gaMixsNffb3Es8kltVW8z2/wixhFpkXzW3ZrgF
         dxY0j/gOWxTqlDjJUxAnvam9lMHdQFlROM2bMCAHE00FbHcGTFGotktAnISOYPdsxE
         bCT4Rc/JE7ccw==
Date:   Fri, 21 Jul 2023 09:48:16 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linuxarm@huawei.com, Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        Gregory Price <gregory.price@memverge.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, fan.ni@samsung.com,
        a.manzanares@samsung.com
Subject: Re: [RFC PATCH v4 2/4] cxl: mbox: Factor out the mbox specific data
 for reuse in switch cci
Message-ID: <klyeobxdmjsmbbu43pllrdu5uzcmply7ijdlaxegeriutzhxgs@ywp3ymuw5uqb>
References: <20230719091931.27799-1-Jonathan.Cameron@huawei.com>
 <20230719091931.27799-3-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230719091931.27799-3-Jonathan.Cameron@huawei.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 19 Jul 2023, Jonathan Cameron wrote:

> #ifndef __CXLMBOX_H__
> #define __CXLMBOX_H__

Unrelated but looks like cxlmem.h needs s/__CXL_MEM_H__/__CXLMEM_H__

>
>-struct cxl_dev_state;
>-int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds);
>-bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds);
>+#include <linux/irqreturn.h>
>+#include <linux/export.h>
>+#include <linux/io.h>
>+
>+#include <uapi/linux/cxl_mem.h>
>+
>+struct device;
>+struct cxl_mbox_cmd;

Would it make sense to instead move the whole cxl_mbox_cmd out of
cxlmem.h into here? Same for the cmd rc table stuff. Then cxlmem
can include cxlmbox.

>+struct cxl_mbox {
>+	struct device *dev; /* Used for debug prints */
>+	size_t payload_size;
>+	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
>+	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>+	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
>+	struct rcuwait mbox_wait;
>+	int (*mbox_send)(struct cxl_mbox *mbox,
>+			 struct cxl_mbox_cmd *cmd);
>+	bool (*special_irq)(struct cxl_mbox *mbox, u16 opcode);
>+	void (*special_init_poll)(struct cxl_mbox *mbox);
>+	bool (*special_bg)(struct cxl_mbox *mbox, u16 opcode);
>+	u64 (*get_status)(struct cxl_mbox *mbox);
>+	bool (*can_run)(struct cxl_mbox *mbox, u16 opcode);
>+	void (*extra_cmds)(struct cxl_mbox *mbox, u16 opcode);

Ok, so most of these corner cases are wrt Sanitize. Do you have
anything in mind what would require such any additional users
in the future (such as completely taking over the device), beyond
pci mailbox? Otherwise this feels too ad-hoc with only the naming
being generic. Perhaps instead have some sort of mbox->type and
handle accordingly directly in the core mbox calls? It would be
nice to have these callbacks somewhat documented.

Also the 'can_run' name is a bit disconnected from the sanitize
special case, maybe be rename to something like 'special_canrun'?

>+	/* Also needs access to registers */
>+	void __iomem *status, *mbox;
>+};
>+

Thanks,
Davidlohr
