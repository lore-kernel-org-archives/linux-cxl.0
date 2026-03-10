Received: from sienna.cherry.relay.mailchannels.net (sienna.cherry.relay.mailchannels.net [23.83.223.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F1B33065A;
	Tue, 10 Mar 2026 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168407; cv=pass; b=dMDYEKaedVl5sELyFfoEdoCi3qfRNq4a5r1R409nPVr2UYUqG+bd3F1wYpOhyOKvQhNrA/YopUtmWTP5ePgI07LzT3RSKVbTUMz4m/Px59kn8F/6Jd7ISubZtnrRGSDqA/RNkNRDqDzMp/Jr5KAQ8KcAN+b4Dr4uHYFo2dp1gAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168407; c=relaxed/simple;
	bh=qlhKlCfJBciuCMXdXjhj+xWCU2tr+8QjsIpiy1XZSwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXMHI+yXUZO6TBTmLjoQ41RlWpJnaoO19Q7qPoA8pkGDGl/eHU8tHiPM5e6rNEOTX/KBbZFI17S0mKdkyy0jOo+eb9LxLYQkCkG8n7s4up4d1ySgE0tmJdVTi4GOBl8EGy4oUjk37dkRMnDSCGF94lneupvI6ckQB9YE3e0cJI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=nmZyDtGz; arc=pass smtp.client-ip=23.83.223.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="nmZyDtGz"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 417DF4C17BF;
	Tue, 10 Mar 2026 18:36:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a208.dreamhost.com (trex-green-8.trex.outbound.svc.cluster.local [100.109.9.43])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C33AD4C1940;
	Tue, 10 Mar 2026 18:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1773167807;
	b=YM22D922fm8mZnNmM+7SOtfLmOlt++Tz26NFwqddtqstERB0rOmiAwJVOnYfDZuA3jqBAg
	mh0xHZaoIWNss8yaVtxDefkkKTQ9iOVbw9pTazvelnRmeBSBVLuRapvIhVrGDeLC3sZST8
	bDxItcxCoDwkUIEnWffktGA7LUkYDXeIp7xs3MQhKGfQCV7LFAAAZPzjqdMbY7CTskrYmr
	nooFCUllSbl4Zkp/iMi1CqqRhRppl5vbwbvOQGdQ6c6OPi2DbxCxI8rtIdX2jn3YtjW5cO
	UbCTH0ciBm9SuHH1IHHi6j/nG0hjlbKoFZ/l1NZzDEc4w9r41QushUTRCy5cGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1773167807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CfySySbiE1E8c1l+WsVSYF5eL7UvGMRFwb1dpqehgLw=;
	b=m/PlKqiASdjQK8cp5U+akLJvwqn+9hMKTmHpPVPBiWaS4eFm2FdaO+pqY0f+d4qvxsCHWd
	yixNb3Q3oOXjRMcS5LG3IJCl8/lvPb1cLT+5vBTOIDxTaHxBc4eLmvschONO2RhHI2w1Ls
	G2r0ej8W9Yq8xgWSrXSmekbrwIVIdZ7o29sNPDoi8eA3mQOell+nFl5wvmDo5txidMjVaP
	hucw+1Jmjb4PO2Z7t8ouvSZ5eL+UTQuPgkkNNpm8yps0RnoWAKJD7DAGMdaMlzzrY5wgUl
	wgLx7oDGgjSemFwZwdIdO9iqqgOJDWfqVWnYGYDF10GZHW/yAxGgrjR/KbkfAg==
ARC-Authentication-Results: i=1;
	rspamd-8f47468b4-d4xdm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Macabre-Tangy: 0638875f6062e340_1773167808092_18033793
X-MC-Loop-Signature: 1773167808092:2366275725
X-MC-Ingress-Time: 1773167808091
Received: from pdx1-sub0-mail-a208.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.9.43 (trex/7.1.3);
	Tue, 10 Mar 2026 18:36:48 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a208.dreamhost.com (Postfix) with ESMTPSA id 4fVjJv0YcTz1dS;
	Tue, 10 Mar 2026 11:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1773167807;
	bh=CfySySbiE1E8c1l+WsVSYF5eL7UvGMRFwb1dpqehgLw=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=nmZyDtGzknMFMii2BP7kkyP9tDEfWdvujKkGEC1LRZFQEcrg4fXzYa/trlIU+tRVi
	 slJyi0DyCuFLH5DqVJ6lKxpqsAJHH9nRyQr9p2De7Ij2BFNQfbKt7gEL9TOPt74a1V
	 DmqtSylYev4dTHcfRe+2qmnutOSXsjIasTjdV7XJ4a1SHwubwOo9bEH9Gaesq/+gjE
	 jUP7Bs8CMyR4YAwO99tjlpDyZ4Xyw4+l5WddT54k968bLolXie5VKktCNESl5xXPkW
	 /kemAGokv1J5oIu636W7DFwVvcHhUWaWzw5d6nvoAOKmJ8rHWDGrbIdveew1M94lqk
	 Um7B8myGp9lZA==
Date: Tue, 10 Mar 2026 11:36:44 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ben Widawsky <bwidawsk@kernel.org>, daveti@purdue.edu,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Fix a race bug in delete_region_store
Message-ID: <20260310183644.4rwc7ilmzy4t5xp6@offworld>
References: <20260308185958.2453707-2-iam@sung-woo.kim>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260308185958.2453707-2-iam@sung-woo.kim>
User-Agent: NeoMutt/20220429

On Sun, 08 Mar 2026, Sungwoo Kim wrote:

>A race exists when two concurrent sysfs writes to delete_region specify
>the same region name. Both calls succeed in cxl_find_region_by_name()
>(which only does device_find_child_by_name and takes a reference), and
>both then proceed to call devm_release_action(). The first call atomically
>removes and releases the devres entry successfully. The second call finds
>no matching entry, causing devres_release() to return -ENOENT, which trips
>the WARN_ON.

afaict the splat is also triggable via devres_release_all(), ie: unbinding
the host bridge. Basically cxl_find_region_by_name() succeeds because the
region hasn't been device_del()'d yet:

CPU0					CPU1
devres_release_all()
   // take devres_lock
   remove_nodes(devres_head) // mv to local todo
   // drop devres_lock                   delete_region_store()
                                           cxlr = cxl_find_region_by_name()  // success
                                           devm_release_action(unregister_region)
                                             devres_release()
                                               devres_remove()
                                                 // hold devres_lock
                                                 find_dr(devres_head) // does not find it
                                             WARN_ON(-ENOENT)
   release_nodes() // drain todo
     unregister_region(cxlr) // release() cb
       device_del()
       
>Fix this by replacing devm_release_action() with devm_remove_action_nowarn()
>followed by a manual call to unregister_region(). devm_remove_action_nowarn()
>removes the devres tracking entry and returns an error code.

While devm_remove_action_nowarn() has only a single driver user (gpio), using it
here would seem to fit the requirement of independent lifetime management; and
ultimately these races seem benign as unregister_region() is only being called
once.

>------------[ cut here ]------------
>WARNING: drivers/base/devres.c:824 at devm_release_action drivers/base/devres.c:824 [inline], CPU#0: syz.1.12224/47589
>WARNING: drivers/base/devres.c:824 at devm_release_action+0x2b2/0x360 drivers/base/devres.c:817, CPU#0: syz.1.12224/47589

I see you are using syzkaller; I added cxl support as well a while back based
on the usb fuzzying approach, and also triggered this issue (which was in my
to-investigate backlog, so glad you ran into this).

Thanks,
Davidlohr
