Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24042C6379F
	for <linux-cxl@archiver.kernel.org>; Thu, 23 Feb 2023 17:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBWRLB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 23 Feb 2023 12:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBWRLA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 23 Feb 2023 12:11:00 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689623B847
        for <linux-cxl@vger.kernel.org>; Thu, 23 Feb 2023 09:10:54 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2F89D5019C7;
        Thu, 23 Feb 2023 17:10:53 +0000 (UTC)
Received: from pdx1-sub0-mail-a206.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A236450179D;
        Thu, 23 Feb 2023 17:10:52 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677172252; a=rsa-sha256;
        cv=none;
        b=JanajbU7igFNcJYxMsr6YuXQTItAumc1PqcpKOckxjdcOogXQwOKr0+p0UWgzMk+Jumutk
        lwyQHll6N38F8mm2w8br4ee8jQ7Fr84gV+LtYLMj1d1Cue7CzCCo6rhuH0ZAngMM4LJrU7
        2F4VOhXP31DIb0lkr3DvtoWNS+1IKE+jfU4FLmuTjnwL0UbP0DE2DiYcWgCzVJY66iL9p1
        F0sv8K3fdvFxmhppTYwGIHpSNeOJqDNGEYcyimsLsIsOcSiFwW0nE+NdLmRkjd4yDa70gr
        86jMyP6xfi2h+t3T4IAo/ZpST80RjoqHwBYAPf+7MFfq3F9vUs1Pg7EYOqbpjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677172252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=uz8KKm6OZvNtWacNYhG0xzGj1swr6Ko9tvUtmoluc+s=;
        b=Byxv8EjjArE/0AXNoh9mR8gmbV9gbHqv1MPguO55GYTxFpdh9Z/2TyhrJZyolrdwAvxziD
        n1SAmZBtaR4jYTBcCpOT7uuVsb/jXpBYrj39Juy+HBoziXTS49RFAp2gObbz8/BgSqgdsW
        uaNCsC0a+fDtwB3u5RGo99k+PZFkGt44yr7dZ1rM6XTy9uO6ChpZKzNK0z8kpa/fhBdYEL
        HyqsmozeKAEB6nAGBp+LK2ss1OQqsGT3eKQDxHDJl9QIZxmnZ8qgLc+Vb5zRt439AJH02Z
        5UYUK83JeNEXlCOLlCdSnDHJ2wT8MPF4XEfg8cBUUUu2u/SOVUCJSU2g4pJQqQ==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-h8z9d;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Supply-Celery: 0bd8517e08ace26f_1677172253005_1191854448
X-MC-Loop-Signature: 1677172253005:2744699058
X-MC-Ingress-Time: 1677172253005
Received: from pdx1-sub0-mail-a206.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.74.37 (trex/6.7.1);
        Thu, 23 Feb 2023 17:10:53 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a206.dreamhost.com (Postfix) with ESMTPSA id 4PN00W5F2gz7F;
        Thu, 23 Feb 2023 09:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677172252;
        bh=uz8KKm6OZvNtWacNYhG0xzGj1swr6Ko9tvUtmoluc+s=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Cb4xlQhdYW/sCtg/sbg2ryiD8x+g4sIkIzw73aFQNU8cqzgLvwBRA1YAz3PRgNnz9
         1Q5RxrhMyWd/FQd+f4ExtFQIry8pfrcjTN2nmYY0DiA5o1NpInIHM2ck+S4G4CWNtk
         ZS/EGysmt9AINrAo5trg+zIetnw4LwAqJXMK4kB1sXDPAl7XNFCOt57vzkd9sXN3Hv
         yIDpHwVzVtvgZvMCdtpM6GzmSScGr41mQ01voeoTdadEhF2jdVgfJfkquHvnSi7MIH
         19AczfDGOIpLELhClbsRosmS55zgv8DwtD1UErXiXyGtirpWpewXbfsMMYX8BTdmC8
         NdRFHo7Jve7SA==
Date:   Thu, 23 Feb 2023 08:42:27 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Nabeel M Mohamed <nabeelmd.linux@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com
Subject: Re: [PATCH v2] cxl/pci: Set the device timestamp
Message-ID: <20230223164227.djns4grt3qeydmn6@offworld>
References: <20230130151327.32415-1-Jonathan.Cameron@huawei.com>
 <Y/Y19p8hqgYGkkKK@nabeel-linux.myguest.virtualbox.org>
 <20230222162700.00006d0f@Huawei.com>
 <Y/bjnb0gmmpkjk8r@nabeel-linux.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y/bjnb0gmmpkjk8r@nabeel-linux.myguest.virtualbox.org>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 22 Feb 2023, Nabeel M Mohamed wrote:

>So, I'm wondering if there's any checklist listing the prerequisites
>for submitting a patch to the CXL driver - for instance, requirements
>on adding new tests for coverage, any existing CXL regression suites
>that the patch must pass, etc.

Btw we might want to support timestamps in the mock device, no? I am
aware that qemu has both get and set.

--<8-----
[PATCH] cxl/test: Add mock test for set_timestamp

Support the command testing in a unit-test fashion.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
  tools/testing/cxl/test/mem.c | 23 +++++++++++++++++++++++
  1 file changed, 23 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 9263b04d35f7..09511f2fbe54 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -98,6 +98,7 @@ struct cxl_mockmem_data {
  	int master_limit;
  	struct mock_event_store mes;
  	u8 event_buf[SZ_4K];
+	u64 timestamp;
  };
  
  static struct mock_event_log *event_find_log(struct device *dev, int log_type)
@@ -361,6 +362,21 @@ struct cxl_event_mem_module mem_module = {
  	}
  };
  
+static int mock_set_timestamp(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
+	struct cxl_mbox_set_timestamp_in *ts = cmd->payload_in;
+
+	if (cmd->size_in != sizeof(*ts))
+		return -EINVAL;
+
+	if (cmd->size_out != 0)
+		return -EINVAL;
+
+	mdata->timestamp = le64_to_cpu(ts->timestamp);
+	return 0;
+}
+
  static void cxl_mock_add_event_logs(struct mock_event_store *mes)
  {
  	put_unaligned_le16(CXL_GMER_VALID_CHANNEL | CXL_GMER_VALID_RANK,
@@ -894,6 +910,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
  	int rc = -EIO;
  
  	switch (cmd->opcode) {
+	case CXL_MBOX_OP_SET_TIMESTAMP:
+		rc = mock_set_timestamp(cxlds, cmd);
+		break;
  	case CXL_MBOX_OP_GET_SUPPORTED_LOGS:
  		rc = mock_gsl(cmd);
  		break;
@@ -1010,6 +1029,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
  	if (rc)
  		return rc;
  
+	rc = cxl_set_timestamp(cxlds);
+	if (rc)
+		return rc;
+
  	rc = cxl_dev_state_identify(cxlds);
  	if (rc)
  		return rc;
-- 
2.39.0

