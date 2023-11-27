Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="DAYM1HJq"
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A6419D
	for <linux-cxl@vger.kernel.org>; Mon, 27 Nov 2023 13:20:44 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8230D102B4C;
	Mon, 27 Nov 2023 21:20:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a286.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id CF19E102AF1;
	Mon, 27 Nov 2023 21:20:42 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1701120042; a=rsa-sha256;
	cv=none;
	b=BKP6KgXMxBHjkB3Zw8z87N0VWcmU1Cq7cfoW1SG8jKGoc5CKCU/yBzk+sOAD737082ihS/
	JxiDAesLy7TK6+uuMHONptZHSTsa9Q+egkPhIf0aCUfTmKtn/gNnwHakEY/HD4ErKllmXg
	My49L5H0azXqV70Oz252fmc9K58gCax4sZ0hnRornnIK/xMJIttSd8iiyGXbBYPM+r+u3V
	hcXk5/pC2nhUNcpgOQ8F7LINpDihDLZqKTRSXzlhp+1yu+v7pmAyScAuY4uB/mO/N468Pl
	xszjV7YRY4w4nv5x1+Mje9iWBOdAccHub3H52wZiGtZwKIr3g0OvoiNbLGD5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1701120042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=EhWnmneJWEgO9jABkWQwK2A5tmC7vjD6TGryyQg7eUY=;
	b=TY8g3b1zxI4L1FVbtSd+8qjJ2AK60Uu7TG1hQJPsf56jTXgPl2zRtThuYWuMc+fBEU3fWU
	4NhlwhdQP8lrnD7lehn53z4PcnxsiKwxeUlye2xHBx5ScvVSceOxHtHpKx7q9mFUTVBTu3
	Xi4jwWs7HWAd0GFWYwpeW/2P6E3Gwqgm3O4NiW0nMz2FdbA7q35zc1exEF9OFe81gJWXEP
	rTBzS9cd9KY12eprHwNBomtuwZmj7eDQfM1lqIKq3gYQ9+Hdy8rAp19XnU4ZpmbtIfGa6f
	iXd2wR0sXWvA0vBCzBmH3j/dX62nX32KhhSb52w1kvEuKkBZeUxYg+VeuL8qRA==
ARC-Authentication-Results: i=1;
	rspamd-d88d8bd54-rthfs;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spot-Cooperative: 4883e570041aab6c_1701120043313_2510861249
X-MC-Loop-Signature: 1701120043313:2504087452
X-MC-Ingress-Time: 1701120043313
Received: from pdx1-sub0-mail-a286.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.209.6 (trex/6.9.2);
	Mon, 27 Nov 2023 21:20:43 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a286.dreamhost.com (Postfix) with ESMTPSA id 4SfJQy0cNPz1j;
	Mon, 27 Nov 2023 13:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1701120042;
	bh=EhWnmneJWEgO9jABkWQwK2A5tmC7vjD6TGryyQg7eUY=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=DAYM1HJql0mzIWtmrb0lK4cfki8o4vYu1DMdmfCniVmlhGVGcBFdhiifYuUZdhy46
	 2AtD3NrOcxlMTSZf9ZLyUVG/P74dsYvmw7OeSIpHhFhiLLF/5JSTmJ//ldsw/OUgFz
	 4DlTCyoq7VEW12ncLBixMWShN+AaxQll74mof/OwmhWVdAybnc4I+Od5USl06SqaCq
	 C2U9szNBk6Pj+2QbC7caiegUszScr/qMYbIKbzA+0FXNpjJd4TkV/YrH5eZFo66UVR
	 oa+JtQrGUvhnTpTaBTZ2CNJkIYKtOmEY/R0l038uvEpcp4W0mrXWlDFvcP/mmQetHv
	 BYJTHCCxPBSrg==
Date: Mon, 27 Nov 2023 13:20:39 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: alison.schofield@intel.com
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/2] cxl/core: Always hold region_rwsem while reading
 poison lists
Message-ID: <20231127212039.vnbhmpnjlwsn6v3n@offworld>
References: <cover.1701041440.git.alison.schofield@intel.com>
 <08e8e7ec9a3413b91d51de39e385653494b1eed0.1701041440.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <08e8e7ec9a3413b91d51de39e385653494b1eed0.1701041440.git.alison.schofield@intel.com>
User-Agent: NeoMutt/20220429

On Sun, 26 Nov 2023, alison.schofield@intel.com wrote:

>From: Alison Schofield <alison.schofield@intel.com>
>
>A read of a device poison list is triggered via a sysfs attribute
>and the results are logged as kernel trace events of type cxl_poison.
>The work is managed by either: a) the region driver when one of more
>regions map the device, or by b) the memdev driver when no regions
>map the device.
>
>In the case of a) the region driver holds the region_rwsem while
>reading the poison by committed endpoint decoder mappings and for
>any unmapped resources. This makes sure that the cxl_poison trace
>event trace reports valid region info. (Region name, HPA, and UUID).
>
>In the case of b) the memdev driver holds the dpa_rwsem preventing
>new DPA resources from being attached to a region. However, it leaves
>a gap between region attach and decoder commit actions. If a DPA in
>the gap is in the poison list, the cxl_poison trace event will omit
>the region info.
>
>Close the gap by holding the region_rwsem and the dpa_rwsem when
>reading poison per memdev. Since both methods now hold both locks,
>down_read both from the caller. Doing so also addresses the lockdep
>assert that found this issue:
>Commit 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper")
>
>Fixes: 7ff6ad107588 ("cxl/memdev: Add trigger_poison_list sysfs attribute")
>Fixes: f0832a586396 ("cxl/region: Provide region info to the cxl_poison trace event")
>Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
