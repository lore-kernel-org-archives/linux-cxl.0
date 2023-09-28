Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B430AE82CB7
	for <linux-cxl@archiver.kernel.org>; Thu, 28 Sep 2023 01:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjI1BPk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 27 Sep 2023 21:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1BPj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 27 Sep 2023 21:15:39 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16669F5
        for <linux-cxl@vger.kernel.org>; Wed, 27 Sep 2023 18:15:38 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 75FCF2C1EE2;
        Thu, 28 Sep 2023 01:15:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a245.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id F2A2D2C2629;
        Thu, 28 Sep 2023 01:15:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1695863737; a=rsa-sha256;
        cv=none;
        b=OBkVVfCqvbmvQa3k1ZannAz1/Fo1Sfk/zj2IlvjFwIXinEh/87NymaPdap+IZ3HaaM3U3h
        a9+vWanDo9sd4Ndicy/r9qutF+apwcEqSxjKPEDcJ1jJIb4pw3VY3RX+YV5Xr7KwAVeD8S
        G9phND2bcDox4tWQAhBvCGFyREhm0ldzZx8HRyRquKVZ/4sfJNOjpt/IQnn/bRPD9eltbt
        xNi2V3lmoUH+iPrl556cJWGaEi7H6k3HomUmFXfPliZEEApsN16U5+HCUu6sjKLpEWjugd
        mse3BR9tGSegLnP6E6d/RfmQNCSLKmMCazX+mrLjMNINvdi05gY8WYndjZ2tkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1695863737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=xidGMFpP86P2KABmgTP3/zaAt2yVMl1Tf5qboyo+oLs=;
        b=bhKHOGRmuVFtz8nzAg6SA26qE5i0zesPfcsDL84Y/tayoqvdCM+gmpRAGDkICNo9xaSxt6
        rDZbG2KG274dqH/9Wk8xQPYiKTYW31Bb4+L9PDb1uYFMEh69gkzf6K33EJF7gv+2rlhP4D
        GBEveXlPXAaKV0aKqNOKIpb2memnAAlAzdgvsn90i2pVgCVYVzD0n+aweFBfFFwVEEb4rG
        kGb1760xADz6oZvVjJssJVaxaR8t52x/vseSdar5GUZDN129J/KkqBtgcZ/frnd06o4TCW
        NVNHwLmlY6fNb/FRdGGR7T/7NvMIpPZGicyl383l8+FwryxVwX1WcrOPI+Nmvg==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-fdr96;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Turn-Keen: 43b72fc255596889_1695863737285_2768390240
X-MC-Loop-Signature: 1695863737285:3930877781
X-MC-Ingress-Time: 1695863737285
Received: from pdx1-sub0-mail-a245.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.99.159.71 (trex/6.9.1);
        Thu, 28 Sep 2023 01:15:37 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a245.dreamhost.com (Postfix) with ESMTPSA id 4RwwX82jRtz2l;
        Wed, 27 Sep 2023 18:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1695863736;
        bh=xidGMFpP86P2KABmgTP3/zaAt2yVMl1Tf5qboyo+oLs=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=rVMcDZHgfUdgri2sofjtDNrqXgYhVHxGsbLtMxAqAOQm8panilHBBnbiMhmemjp7N
         QdwNkF1SGLoxga+RPxTXFzAFKchFeAHdu28QoFdx2tiVsam7xdMqwrnfyMtXEUedbL
         qqqbig1OLUWgHoyqNHQZh1mO5z1mObDBtU/c7yb/Ca1NYb1j2iGDA0i/nRvE+wuyFj
         aogIpZ23LYboZ0bS8B8S7pQW5o4s/QHGQo312R6BxLmtZv6QvldndVzbBIk8IcC482
         rjACLj7LQ/RU+sDX5aNa6OO6/gBWiE+EoXWKpOneR2octDM/VKqrzsyIhb9EXvE+5+
         0LZJ0C48PqAKA==
Date:   Wed, 27 Sep 2023 18:15:28 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, jonathan.cameron@huawei.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH v3] cxl: Add committed sysfs attribute to CXL decoder
Message-ID: <4eqkiupizkzj6ydlp5c6eyviofnbyuvknilujaq33spcpoytdp@u2xwy5gqdb6i>
References: <169575398814.4028282.11591056324662123995.stgit@djiang5-mobl3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <169575398814.4028282.11591056324662123995.stgit@djiang5-mobl3>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 26 Sep 2023, Dave Jiang wrote:

>This attribute allows cxl-cli to determine whether a decoder is
>actively participating in a region. This is only a snapshot of the
>state, and doesn't offer any protection or serialization against a
>concurrent disable-region operation.
>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>Suggested-by: Dan Williams <dan.j.williams@intel.com>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
>Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>
>---
>v3:
>- Update commit log verbiage. (Vishal)
>- Change code to conform with existing code. (Dan)
>v2:
>- Use FIELD_GET() (Jonathan)
>---
> Documentation/ABI/testing/sysfs-bus-cxl |    7 +++++++
> drivers/cxl/core/port.c                 |   12 ++++++++++++
> 2 files changed, 19 insertions(+)
>
>diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
>index 087f762ebfd5..ef3fc9fe9d0d 100644
>--- a/Documentation/ABI/testing/sysfs-bus-cxl
>+++ b/Documentation/ABI/testing/sysfs-bus-cxl
>@@ -369,6 +369,13 @@ Description:
>		provided it is currently idle / not bound to a driver.
>
>
>+What:		/sys/bus/cxl/devices/decoderX.Y/committed
>+Date:		Sep, 2023
>+KernelVersion:	v6.7
>+Contact:	linux-cxl@vger.kernel.org
>+Description:
>+		(RO) Indicates whether the decoder is committed.
>+
> What:		/sys/bus/cxl/devices/regionZ/uuid
> Date:		May, 2022
> KernelVersion:	v6.0
>diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>index 724be8448eb4..20919ffbc1a4 100644
>--- a/drivers/cxl/core/port.c
>+++ b/drivers/cxl/core/port.c
>@@ -277,12 +277,24 @@ static ssize_t interleave_ways_show(struct device *dev,
>
> static DEVICE_ATTR_RO(interleave_ways);
>
>+static ssize_t committed_show(struct device *dev,
>+			      struct device_attribute *attr, char *buf)
>+{
>+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
>+	bool enabled = cxld->flags & CXL_DECODER_F_ENABLE;
>+
>+	return sysfs_emit(buf, "%d\n", enabled);
>+}
>+
>+static DEVICE_ATTR_RO(committed);
>+
> static struct attribute *cxl_decoder_base_attrs[] = {
>	&dev_attr_start.attr,
>	&dev_attr_size.attr,
>	&dev_attr_locked.attr,
>	&dev_attr_interleave_granularity.attr,
>	&dev_attr_interleave_ways.attr,
>+	&dev_attr_committed.attr,
>	NULL,
> };
>
>
>
