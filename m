Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F239BC77B75
	for <linux-cxl@archiver.kernel.org>; Fri,  5 May 2023 21:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjEEV2V (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 May 2023 17:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjEEV2U (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 May 2023 17:28:20 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A9B40F9
        for <linux-cxl@vger.kernel.org>; Fri,  5 May 2023 14:27:56 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B3DDF7E25C5;
        Fri,  5 May 2023 21:27:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a226.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3E76F7E1E85;
        Fri,  5 May 2023 21:27:55 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1683322075; a=rsa-sha256;
        cv=none;
        b=kwZU7/EX2ugFo0uPlmQQMmCwOVDh4OFJoe5ut6mhdzE+/EhoHvNZlTEijkfePWHfY4G4vP
        nPidBN68ypCvY+WR6OE62GfaW4kHZPTpx3+v+wYSu+cuo+W85N/jLTajDXhQ0Flt1oCEsH
        ryB5sL4ltvIGCN2v7SEbUpB0Z8OBQONNf67qLiF85JDoPFTHYrgcuJHy55dlosmkUxDWCi
        f7li+EN5F1lesTyURpaSbxIM51Ys+rM+bGRxrM2btpjLA84a4VZYdDw3SOkv8es7ypK64w
        eOoHREgh0Na7krRcpyrmu1N33fuMflj3qkGyhFEaIB+90RnMPB2e0ZADlrRA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1683322075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=iDn056hBga/okhFcGUvoF8SgjUMyDeyl6U2I88ktYdc=;
        b=9sutek0oTPh2JtNuFpgoceJB4i84ZI2hd86k+SceR1u6t9bwbhCi7IkY+CqwmdZ0BQwwRj
        EJNBhRP71PW5dWsoq6lZUl4haXgAUykgU3qKMAeDYLfrsQ9YUdq2klE9bOThcGfRx/R9sV
        OB6qbVwsfCX5w/ImLfuG8zlJAJDKlTXIaN4OTEsB+EBpfcrvMFUvhnZtXeGk7Hcq09Vu2u
        MUUFQ6yau6od6/O9zqQ3euadxv0r9LjhnRI4Az3lOH4DNjFGCAzKleKqJmVqk7+N83VES5
        +S9uW8cA8poyU6zRrzQJL5GJHV+xMeJDquxobTXYNKnxU8ajw66qrZRy557L3g==
ARC-Authentication-Results: i=1;
        rspamd-79bb5575d7-sp8j9;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cooperative-Reaction: 556132ba53183fbf_1683322075556_2059485873
X-MC-Loop-Signature: 1683322075556:478497289
X-MC-Ingress-Time: 1683322075556
Received: from pdx1-sub0-mail-a226.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.48.86 (trex/6.7.2);
        Fri, 05 May 2023 21:27:55 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a226.dreamhost.com (Postfix) with ESMTPSA id 4QCkLL4HdLz3K;
        Fri,  5 May 2023 14:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1683322075;
        bh=iDn056hBga/okhFcGUvoF8SgjUMyDeyl6U2I88ktYdc=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=JFtMg9Z07XHsf6vQEM8LNNcGzdM2PxD5i9FtUXTXuXC6X8wPtoAHqxs9jYlth7X/k
         Y92rQvgY5ot0oXcEPhJzPf9SKFkaCWN1KIjHlZh40xHuG5Hr5vXWLPJHxDYquKBDnr
         xdw+y6ZB2AskCdZrfhKRqu/SVLglGgNk+TSJBNI+SpDcAFwHf7re1/GJZ8FdQUKUEd
         0NT6y1b+5fUA78tuQu3nSg8HhoZYTQ7N1Sht+E7trddq/Vrawkqrv6GynuGcVIeZ2p
         2JYhrctFjY0TLgvSo3RKvkqXcCJuzO7ublBvbq5S9lWgNJSRCd6oiHS5O+n0YkE8pN
         A1iELEDXlm4Eg==
Date:   Fri, 5 May 2023 13:55:29 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Subject: Re: [PATCH 1/3] cxl: Export QTG ids from CFMWS to sysfs as qos_class
 attribute
Message-ID: <3u24sfpelji37abhbha4b6b2zh2vn2hocbwcyjo4j7k7sgflsb@mvpl7s7hckt2>
References: <168330433154.1986478.2238692205077357255.stgit@djiang5-mobl3>
 <168330452292.1986478.17259063377180091918.stgit@djiang5-mobl3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <168330452292.1986478.17259063377180091918.stgit@djiang5-mobl3>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 05 May 2023, Dave Jiang wrote:

>Export the QoS Throttling Group ID from the CXL Fixed Memory Window
>Structure (CFMWS) under the root decoder sysfs attributes as qos_class.
>
>CXL rev3.0 9.17.1.3 CXL Fixed Memory Window Structure (CFMWS)
>
>cxl cli will use this id to match with the _DSM retrieved id for a
>hot-plugged CXL memory device DPA memory range to make sure that the
>DPA range is under the right CFMWS window.
>
>Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
