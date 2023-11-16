Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="BG8NZU85"
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8445493
	for <linux-cxl@vger.kernel.org>; Thu, 16 Nov 2023 14:14:46 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D6D19416E3;
	Thu, 16 Nov 2023 22:14:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a201.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6B52C41744;
	Thu, 16 Nov 2023 22:14:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1700172885; a=rsa-sha256;
	cv=none;
	b=xLqViPa8pVmvF9A/c962swnCFCHVSu6sOJCv5FrQ20SG9wgXBSdYY7s0P5cbyc7URLPqDF
	acT3mxH+swlfWC0jWTPiaUY4RejCnRPKk2eLmy2op1SD3TTiKq/3gV/aHwHXM8jpABnunD
	dzkE9l7xnOkaOijdIXHa1QqoFYK0EHNrYVmfewC2C/nEkg3z3KUneoCtkKJwdLyeJTJ/BA
	tMdC2g9g1vSreGZp4GBiigD/KiiXeNnLyKgcv4jOgl/3y+2TSq6pfa+SeGvEAKEMqL/jnc
	YnqxYiZMvqibqOcYjC2mIImzsOuZYDL24ROKalY3FNzyRh8/QnRxqdYH1Z1VSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1700172885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TW2XNnoYNxdcPFiAuCgHC2+ocKnjPuXnBpNnBg7PfKc=;
	b=1P61VNsOW/wwsA6plDe4UUE0h6orEaaYjm7KHT0ptlkzsJUGRsQqHrtLZZUGiLxanmm85J
	ZUg4BWA2aByuymPeWtzD2045q4vmdOM2+CETq1el/2lcg3lsIY/BizX3IiXkxckyVtwxRZ
	dIdQ0uCPX1gVvFUrURAstna5MVCE9rLcP2OUGHCPeWuLAIEOPTAbO+EJcO+d+jLX0Hz0qJ
	+KxSOK84l4IaWujimgPQ0aU2/USFP3mdwAZop1AApFKfSlFWfoJaeVRerJSr/JojnMlomy
	TdWGSwZiLSPES0FblP65X74iOTOVoNm1vi3CNjfyAiJN8PLqlUeiQMUOE6vDSA==
ARC-Authentication-Results: i=1;
	rspamd-55bcb54c45-fh4zj;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Supply-Dime: 47fe735c62431276_1700172885609_2733401949
X-MC-Loop-Signature: 1700172885609:1333453205
X-MC-Ingress-Time: 1700172885609
Received: from pdx1-sub0-mail-a201.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.100.100 (trex/6.9.2);
	Thu, 16 Nov 2023 22:14:45 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a201.dreamhost.com (Postfix) with ESMTPSA id 4SWZ8N5fKnz4h;
	Thu, 16 Nov 2023 14:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1700172885;
	bh=TW2XNnoYNxdcPFiAuCgHC2+ocKnjPuXnBpNnBg7PfKc=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=BG8NZU854aCPbUxuz2F9sS92F00fZesCbKT9Qus/TMVNWOLxI8HFlpiCUy/N9OBdN
	 ox2ic28kgBb8Ka6SzlGmECXc/U/vnaHcbHEDlb6VL4Hv666+w6wQ1ZnmhypENBUTOo
	 hCats/7c7IuSIzxca47/6y5+uZJ5p92kVixz1xHppdxwGFe391UHQjEHDr0qDudAoB
	 qren8juQOgFeYunfldlxjoFfSgucYtAO3hBA7Uf51Pov5BzkkfQ5xu8kQCipVECLW4
	 tme5ne1jFhdqBt5MYMx16EgdgsddBP383WnG9Gd4o1aXX/ov2G8TW3v+/ztzNdJ35Q
	 1ql8w3g6ERDNg==
Date: Thu, 16 Nov 2023 14:14:37 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: alison.schofield@intel.com
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/core: Hold the region rwsem during poison ops
Message-ID: <tcc2pnjpfpn45nmc7vqgerm4pinjjx25j2dmcxeihoqdwjq2t4@3zk7uadynsoh>
References: <20231114025342.1123681-1-alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231114025342.1123681-1-alison.schofield@intel.com>
User-Agent: NeoMutt/20231006

On Mon, 13 Nov 2023, alison.schofield@intel.com wrote:

>From: Alison Schofield <alison.schofield@intel.com>
>
>Commit 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper")
>added a lockdep_assert_held() to make sure all callers hold the
>region state stable while doing work that depends on the number
>of committed decoders.

Unrelated, but that kind of helper would be better as a static
inline in a header file.

>
>That lockdep assert triggered in poison list, inject, and clear
>functions highlighting a gap between region attach and decoder
>commit where holding the dpa_rwsem is not enough to assure that
>a DPA is not added to a region. In such a case, if poison is
>found in at that DPA, the trace event omits the region info
>that users expect.
>
>Close the gap by snapshotting an unchangeable region state during
>all poison ops. Hold the region_rwsem in all the places that hold
>the dpa_rwsem rather than in the region specific function only.

Makes sense and lock oder is consistent with that of attach_target().
I do think that the interruptible semantics should be kept considering
this is from sysfs/debugfs.

Thanks,
Davidlohr
