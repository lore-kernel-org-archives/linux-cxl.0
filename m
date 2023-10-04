Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CE6E8FDBF
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Oct 2023 00:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjJDAxD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Oct 2023 20:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJDAxC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Oct 2023 20:53:02 -0400
X-Greylist: delayed 118991 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Oct 2023 17:52:59 PDT
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEADA9
        for <linux-cxl@vger.kernel.org>; Tue,  3 Oct 2023 17:52:59 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7D9824C1C8E;
        Wed,  4 Oct 2023 00:52:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E86D24C1AA7;
        Wed,  4 Oct 2023 00:52:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696380779; a=rsa-sha256;
        cv=none;
        b=1POwwC1ztDxHYD94HoyfmbQovwjXQnTAAIRf5kXHcTx1sjqSBof5hN1w2JNh40SMRNU5mg
        OLNYPeMaPtfzVuEQBFKiKVgyAzySnchqF5PPL+bhAjwysvTDvPctshc4UcBRpDP/PR77VK
        w20YRVkF2BGXm/ke8AG7QqZFJU/ngUzutfft1yGnvfIEaXdjsPaEySLDiZNUlBShfmJNwg
        a21CKeYuslzZT+izkrpdxnUoBKf45MlpwYXRQetNAIwUNUjXJqcvvwhgu3BAgaLc/05IKz
        CYNg8pe7J4eZqz2qAHS2gOCuiH+04e/SfkwQUk0ehXKOmLBXdKv5Q0vLGrD6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1696380779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=gp9/hUZJJl5hQEvJC/I3J8Vs2Xi+AORFL8flqjEkDzU=;
        b=nDuQL7taAgCEhjhdQCDinGuOtYCWQAKKqFsrrgtFIebnt8iHdNhvzbZoPRBIVzLbujmXkx
        qU9oIGLjjD+gi2iGg6ym9yT4KjbZgSRlktKijsk+Dw/s6z1lWGy5T7wrvU6r/l/SGtYCGs
        a9LpSWvWGV/9XYcc+TR9/LQVmXbq9oM8IqBAUZV6JRNSpTBUWfbgQc1+5gAuKqiHkdVbF7
        eJezBqL7gLL7WO6d4IYiibMKZrvPSegsUXHPeMKrZYze9j7y2MigqynhFWfL2umPIPOYX+
        7FKUwzTcOgjpGRsPVbMv0ywP39Ajr6jhSrA1ZA0zkFNVXDrTKY2upe5ZBuO3/Q==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-qfxqr;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stretch-Imminent: 27eca697669d9f5d_1696380779230_4167696979
X-MC-Loop-Signature: 1696380779230:3771183684
X-MC-Ingress-Time: 1696380779230
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.122.94.6 (trex/6.9.1);
        Wed, 04 Oct 2023 00:52:59 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4S0blG334xz76;
        Tue,  3 Oct 2023 17:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1696380778;
        bh=gp9/hUZJJl5hQEvJC/I3J8Vs2Xi+AORFL8flqjEkDzU=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=PLuR1iTAPQgKkd8WQPkDshm3RYe9dSS8Lx8oGBmuqBP/qZiAbAqGZEGrUjooNKwMX
         JLbPfl4Odu5m5ns6vTYLOBkEY1TAqw8ZrMNsau86ywjM1H/dONjicijC8xfd5ZG44g
         /xgXonbXb2IAIRupUi8S4I6t451fY9Rgu8xO08KcAiqrDKqtzhOK/f41gEcuht98fe
         ozfkbe5mFo78tpmvZDsM0ycKG6aPKcrbc95vsEw8uQxAh6JF8ZByoFAJozl2rws/aC
         8K3SUWCO0zYdEjib9HDIeSha8Mu9JlfnsUAfJEgbwAx/Wee6vqP9m/S/qgbUXxM9FW
         kqppv9waUiItw==
Date:   Tue, 3 Oct 2023 17:52:55 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, ira.weiny@intel.com
Subject: Re: [PATCH v2 3/4] cxl/pci: Fix sanitize notifier setup
Message-ID: <zs7jliubdhd6e7eabzukvale7bfoltk7ja5lwvvue2df2n2vol@4nhsl2gzdcfw>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602898447.904193.4454973423100628922.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <169602898447.904193.4454973423100628922.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 29 Sep 2023, Dan Williams wrote:

>+static int cxl_sanitize_setup_notifier(struct cxl_memdev *cxlmd)
>+{
>+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>+	struct device *dev = cxlds->dev;

This wants to be dev = &cxlmd->dev;

>+	struct kernfs_node *sec;
>+
>+	if (!test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
>+		return 0;
>+
>+	sec = sysfs_get_dirent(dev->kobj.sd, "security");
>+	if (!sec) {
>+		dev_err(dev, "sanitize notification setup failure\n");

Nit: Should the error message differ from the next one? Maybe s/sanitize/security?

>+		return -ENOENT;
>+	}
>+	mds->security.sanitize_node = sysfs_get_dirent(sec, "state");
>+	sysfs_put(sec);
>+	if (!mds->security.sanitize_node) {
>+		dev_err(dev, "sanitize notification setup failure\n");
>+		return -ENOENT;
>+	}
>+
>+	return devm_add_action_or_reset(dev, cxl_sanitize_teardown_notifier, mds);
>+}
