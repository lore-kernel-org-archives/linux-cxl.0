Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAC6C77B75
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Apr 2023 09:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjDUJz4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Apr 2023 05:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjDUJzs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Apr 2023 05:55:48 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC7EAF35
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 02:55:41 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C3068641639;
        Fri, 21 Apr 2023 09:55:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2C92F6418D8;
        Fri, 21 Apr 2023 09:55:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682070940; a=rsa-sha256;
        cv=none;
        b=4oEwdUl5x1Ds0YsGJnBrsdl74Tq30iJWTfWd7LltfEIRqNudFRo6IIkhFAnDsPcWdwN9UT
        UuCgAI3Q5s5VpF7pkBEohNVJtx3TmfgkjITnB+9VKktn+4u7FWdLBLxHy1okd2ABF7Ntr/
        4M5C7JjbbleWROoPW7rWdCRm8bHU4d+uTBC0iqR1QgJkusoyl/oqtHds2khFhQief0kG47
        m6L81xkJ2p9ymZtb9o0v9Rez8Y5zmwmvONw+mFZNxjgICBLRSo2WsbxPnnEp8jPhPBJ+DJ
        k0gNadyZHB+2nyg1M56j6pA0tjuYqdedFE1QOPHmoRprQJ6uAtcT6oISCsxovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682070940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=g6mPf+xWHnjsKkXHpHaGchJJJRvPKq9pjWWNsZutmKM=;
        b=zYf4p91CSzOOGUdt3hBbFcixRHIQhDRa2nONwmIBwSzpTq7Z7WCBmy2Po6vzf+xrPRBUKl
        z19DGRRjGn4rydqMwoSbf/V6dZ1JRUhcaD8wfJL8pvo/12lulMIVQagN0Y6rryDtWcN4CL
        mub4pbOkCtcLBvXMSJyPZYj2j0nb9xLjInKPsvki3d3/H1ojZQIhCflF+tAfBhFZ0OQvPH
        7HOBlhG3ECjn3GMT2S9H/YZLCQyamDnHupgJLgzMplxNrrc+YTbI6lapLTaTnt7MDKdFRr
        YF+eZ01kpWWi/YmlXVSF4T0j+arJM9JavzK8JwO5gAl/CmXqQ85Ty5Zr3o0RNQ==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-fm7p8;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Occur-Soft: 0df3fe753bca17bd_1682070940621_1363933897
X-MC-Loop-Signature: 1682070940621:206981208
X-MC-Ingress-Time: 1682070940620
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.59.45 (trex/6.7.2);
        Fri, 21 Apr 2023 09:55:40 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4Q2qf32rhYz80;
        Fri, 21 Apr 2023 02:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682070939;
        bh=g6mPf+xWHnjsKkXHpHaGchJJJRvPKq9pjWWNsZutmKM=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=qCUVqEt42voqA0li6IOV7jAsxyTBQZZNEEy81nnjVBrIEG1oPQCRILOvASkw1w5aE
         3CRgcZZ+h6SHjmrlWuewUWyVhqzyEcu1NHS8ouakFxs1yxz7QAlhQk7Hfxb8mx6n3I
         Ox0ITFm8nWEPdJp3JlazHW3a4jwCNxlKmvc0F6r7MnzCLCZeDuDbNtw3uIym0QObky
         mSN4/+dRJJMYM0KTYARkVwF760B6Ni82hetv5pV1+LgNpWkotcFFChRgG8pQvGVdeu
         8FO7u0swWKmye2+eVgty+UnWxC4WxwYdqY9rV/g+wQz82DA2vULo+z96Z/ysGMwtFK
         H3UJ1pNYH51Aw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 7/7] cxl/test: Add Secure Erase opcode support
Date:   Fri, 21 Apr 2023 02:23:21 -0700
Message-Id: <20230421092321.12741-8-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421092321.12741-1-dave@stgolabs.net>
References: <20230421092321.12741-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add support to emulate the CXL the "Secure Erase" operation.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tools/testing/cxl/test/mem.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index d4466cb27947..8a22a4e592c6 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -519,6 +519,30 @@ static int mock_sanitize(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 	return 0; /* assume less than 2 secs, no bg */
 }
 
+static int mock_secure_erase(struct cxl_dev_state *cxlds,
+			     struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
+
+	if (cmd->size_in != 0)
+		return -EINVAL;
+
+	if (cmd->size_out != 0)
+		return -EINVAL;
+
+	if (mdata->security_state & CXL_PMEM_SEC_STATE_USER_PASS_SET) {
+		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+		return -ENXIO;
+	}
+
+	if (mdata->security_state & CXL_PMEM_SEC_STATE_LOCKED) {
+		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
 static int mock_get_security_state(struct cxl_dev_state *cxlds,
 				   struct cxl_mbox_cmd *cmd)
 {
@@ -949,6 +973,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_SANITIZE:
 		rc = mock_sanitize(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_SECURE_ERASE:
+		rc = mock_secure_erase(cxlds, cmd);
+		break;
 	case CXL_MBOX_OP_GET_SECURITY_STATE:
 		rc = mock_get_security_state(cxlds, cmd);
 		break;
-- 
2.40.0

