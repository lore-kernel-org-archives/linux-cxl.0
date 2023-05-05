Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42CFC77B7C
	for <linux-cxl@archiver.kernel.org>; Fri,  5 May 2023 19:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjEET5D (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 May 2023 15:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjEET5B (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 May 2023 15:57:01 -0400
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1151BFC
        for <linux-cxl@vger.kernel.org>; Fri,  5 May 2023 12:56:58 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BB03F8C2026;
        Fri,  5 May 2023 19:48:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a232.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 90FA88C2289;
        Fri,  5 May 2023 19:48:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1683316104; a=rsa-sha256;
        cv=none;
        b=6AN4iulL6cFrdNkQ7G1539oE/jwayFF0CCJLNtUupwJeW+bxPhN3R6v6GDFzWwWbh0LtoK
        PIrV/VqSObJ+y5ls3G+Zd747xYHpBu5nNFWY6X9X0pjCDgFtQGnVgN9SyNI9Gv72QV59fm
        tC601YcaX0mgq9sPiDrBqAFzMYgMjwBrX6a6QLL/4VXS31EY9wIga/q7YInD3ptM8YMC46
        oIlfK5Y9kiV2vqO3fhMaQqWex9KD1MlsHuhR9fPDqT/L7eeVnMXzyp/2a8b0OyYqTPCpVA
        gY47siELRi61s9Eb3WdpANuNe9R/UWN7y96CbrSuYxx6qspqoJe/uQMtf9mQdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1683316104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=VElgoazoyYYS/lhaTN28OCjDZxlYgWceiAOLA6axhUA=;
        b=qkcllRUjmdnOdrO6+k2DOTtnHJufzdhjYWu7x9XYpVz1MSq8CFCQFXu8D4ea3b523d6CXQ
        uR268v3djIdZnWi5T0IwWX4BKBN2cx5ra2fDlXG1/gZV2YnxeUpgxiAgQPlT64slzDZmMU
        l7k1Hrm9vV4VK2JrQlStzU/hqProKqjMUFu2YJ/RbJUoG8zTaiHWYU6Uf+Yfp0IGBqdrD/
        TE2hcRY1hhvt3j1Q6vaFRViCJa49ALpTVQOIDRC5NDK5rfHJXyyicuqQ7hXaiT0Gp9u95v
        wLkHOOE4Y9IFfSIeczhcK5s5/IHeUjnygixYWb5Rpc/8NIytnKXY1xAnEUZj6g==
ARC-Authentication-Results: i=1;
        rspamd-79bb5575d7-d5txb;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Unite-Shrill: 08ee592246855b0a_1683316105479_3657911167
X-MC-Loop-Signature: 1683316105479:410197696
X-MC-Ingress-Time: 1683316105479
Received: from pdx1-sub0-mail-a232.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.48.86 (trex/6.7.2);
        Fri, 05 May 2023 19:48:25 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a232.dreamhost.com (Postfix) with ESMTPSA id 4QCh7W6Lkxz31;
        Fri,  5 May 2023 12:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1683316104;
        bh=VElgoazoyYYS/lhaTN28OCjDZxlYgWceiAOLA6axhUA=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=H0hc2DCJmMdPcSjPq7Yh1C4GPDb0ynB7EhXDM5ARRqPpHBWVULVCgWdXD+fxIe24q
         7EAqGk53eNM00a5c4Kz1/elQvslrOGZo+DcHTtg0mpSHBkogg9VgqJiSZ+YDEIwFM8
         rhdk/pMaiBH6TfBDrkDiWxlsIPyamHsPzkE6QaQdf27jkOY4UFLZmm1TAVRXHOerY0
         8mNRH4ilAHZcPrOXWclnk1WmMPTw/RBW7PXcGBqcc3rd5oEIOpESwQJJwKaME4khwi
         IHP2HfP9B2ikGuahiNgjKQgWnEGRkIM3ZM9X2iVQ2mARAljP9b28vKpRhJTbr2iGNv
         g8GDSkQftn1hA==
Date:   Fri, 5 May 2023 12:15:58 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Subject: Re: [PATCH 2/3] cxl: Add checksum verification to CDAT from CXL
Message-ID: <hrja6figxyf3dhr24cwp3ofuhrw66tdpwprsih6vahnuggm63r@wsixzfbasmoa>
References: <168330433154.1986478.2238692205077357255.stgit@djiang5-mobl3>
 <168330452895.1986478.7758561874383258080.stgit@djiang5-mobl3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <168330452895.1986478.7758561874383258080.stgit@djiang5-mobl3>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 05 May 2023, Dave Jiang wrote:

> /**
>  * read_cdat_data - Read the CDAT data on this port
>  * @port: Port to read data from
>@@ -571,9 +581,17 @@ void read_cdat_data(struct cxl_port *port)
>		/* Don't leave table data allocated on error */
>		devm_kfree(dev, cdat_table);
>		dev_err(dev, "CDAT data read error\n");
>+		return;

Should this be a separate fixlet?

>	}
>
>	port->cdat.table = cdat_table + sizeof(__le32);
>+	if (cdat_checksum(port->cdat.table, cdat_length)) {
>+		/* Don't leave table data allocated on error */
>+		devm_kfree(dev, cdat_table);
>+		dev_err(dev, "CDAT data checksum error\n");
>+		return;
>+	}
>+
>	port->cdat.length = cdat_length;

Upon error, port->cdat should remain consistent (only be set after passing the
checksum. Ie, wouldn't the following be better?

	  cdat_table += sizeof(__le32);
	  if (cdat_checksum()) {
	     ...
	  }
	  port->cdat.table = cdat_table;
	  port->cdat.length = cdat_length;


Thanks,
Davidlohr
