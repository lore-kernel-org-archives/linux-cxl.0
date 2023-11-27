Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="PAz6U2V7"
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00F4113
	for <linux-cxl@vger.kernel.org>; Mon, 27 Nov 2023 09:47:44 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 00F41502800;
	Mon, 27 Nov 2023 17:39:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a293.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 977DF500A1A;
	Mon, 27 Nov 2023 17:39:39 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1701106779; a=rsa-sha256;
	cv=none;
	b=1VhDEkmI4SfPmKqav5zFJju4bLPHQAIKkVTOjoqY0TPyx1eqcUuRFdKclzicsZEE9CCq4v
	uzodTaW2EUQJH5EnyNNw6X+BmVTlxHHyiDn9UDwoWplTtvO32zKVRtyes6JaiC+pYY7BVW
	JI/dAIj8a6COcfLqnuztl2SJ3ziVE052Z+JwhnoAxjxkd7jio5xB1HN1UK8dXh68e2fkI3
	afFHPxcJkJkHdmoaMpv9xv2BXLQ2+Yf51B1Wy7KhSHd4Y7TmrAyGpkG26db0SYpQ7FRwSn
	oTMkjH1MqHBTF4KRFM2PJmUqAqY+n9WTu9/WL1ZDw7pGU/Xmcvl2WHSzPb5bHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1701106779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cCcgUSkXghZz2lsyyccTZkde156X2NEeig8JnyrzWpU=;
	b=BYR1gfmJoeh6JCQsZ+H689rX3uHXbXdOqKdMsS90I2w9kvy6GUMaLFI76ayKasVqHVOPJn
	rsbCq6X0mWbdDpPtzh5btvw/x8QTqBPYKLb+L2p4K2o6sqIx469aZmQSOm+aHwQFFc2ZZH
	i2McT50nFyOmDr3GZeYi27It60NWRIeecydqD3DuR6DiW9XgdNov1k3v6g66flBPacGtkS
	gkgxVKko8E4hp1xOsv48IIXfIjpJ+DEhjhizRT+y8FOxro4NmffK4b2n7SNjMk30hsT1/E
	nAc00aCmzK1JNRKgwXSOOSy0q9yQkZDBp4wzR0eVwpEKIT5r5OkEbD11m8LfGw==
ARC-Authentication-Results: i=1;
	rspamd-696ff67dc8-kcr9t;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whispering-Drop: 2c5f856f467d7b25_1701106779798_1054674915
X-MC-Loop-Signature: 1701106779798:3346318831
X-MC-Ingress-Time: 1701106779798
Received: from pdx1-sub0-mail-a293.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.108.22.63 (trex/6.9.2);
	Mon, 27 Nov 2023 17:39:39 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a293.dreamhost.com (Postfix) with ESMTPSA id 4SfCWt6y2VzDC;
	Mon, 27 Nov 2023 09:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1701106779;
	bh=cCcgUSkXghZz2lsyyccTZkde156X2NEeig8JnyrzWpU=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=PAz6U2V7k/tdSUf6q/YAAjn3Suo/YJYLclYlLhnqvdcWV8qyNIqcyO+64MDGXw+o9
	 fZ807FMNxNYNkKPtN4IYcYikKLHOuv5rJlY4LAUYIsehpxbWlwqUuzad6VWUr+ij0s
	 7hjm/gaAS+MQkM/gq3/YFhiDyIbQTYpIo2WLF4zUCMsfosUPV6TKHuhQjkPf+xUnmf
	 uL8fZNI201T+0gESqrTB13mZn16cMpTx+NJMsvegLuiDbUCOrHmKs2M4pecMBy/kQ/
	 V0gWlhTLMqj/pluzXid17NEbwAsarEQ2C94wSQ/Ytt/MlE0CnHxrCWtf5qBLQwonTq
	 09mbd53c/8OiQ==
Date: Mon, 27 Nov 2023 09:39:36 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	peterz@infradead.org
Subject: Re: [PATCH v3] cxl: Add cxl_region_rwsem around commit_end write
 during decoder enumeration
Message-ID: <20231127173936.jyinrw7a4dtw7los@offworld>
References: <170025232811.2147250.16376901801315194121.stgit@djiang5-mobl3>
 <jhsumngltwjkwpa2o2ktxwjujmuzdzrza2m4fyd44ieva3l2ca@trrhklq6evtg>
 <655e75e929fc0_b2e829478@dwillia2-xfh.jf.intel.com.notmuch>
 <655ea49a7ce96_b2e8294c7@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <655ea49a7ce96_b2e8294c7@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20220429

On Wed, 22 Nov 2023, Dan Williams wrote:

>Dan Williams wrote:
>> Davidlohr Bueso wrote:
>> > On Fri, 17 Nov 2023, Dave Jiang wrote:
>> >
>> > >init_hdm_decoder() modifies port->commit_end without taking the
>> > >cxl_region_rwsem. An assert splat emitted by cxl_num_decoders_committed().
>> > >However looking at the code, it looks like the write version of the rwsem
>> > >needs to be taken due to the modification of commit_end. Wrap the write
>> > >version of the rwsem around reading and writing of commit_end.
>> > >
>> > >Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
>> > >Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> >
>> > Uhmm but do we expect concurrency during the switch/port probing phase?
>>
>> I answered that that detail here in response to Fan:
>>
>> http://lore.kernel.org/r/654eb8ed72ced_46f0294c@dwillia2-mobl3.amr.corp.intel.com.notmuch
>>
>> The takeaway is:
>>
>> "I am in favor of adding the locking rather than depend on a subtle
>> side-effect of how CXL operates, and to avoid adding an unlocked version
>> of cxl_num_decoders_committed()"
>>
>> I will add a note to the changelog to that effect, and drop Fixes: since
>> the lock is not strictly required for correctness in this path.
>
>I rewrote the changelog to this:

Thanks, this clarified my doubt.

>
>Author: Dave Jiang <dave.jiang@intel.com>
>Date:   Fri Nov 17 13:18:48 2023 -0700
>
>    cxl/hdm: Fix a benign lockdep splat
>
>    The new helper "cxl_num_decoders_committed()" added a lockdep assertion
>    to validate that port->commit_end is protected against modification.
>    That assertion fires in init_hdm_decoder() where it is initializing
>    port->commit_end. Given that it is both accessing and writing that
>    property it obstensibly needs the lock.
>
>    In practice, CXL decoder commit rules (must commit in order) and the
>    in-order discovery of device decoders makes the manipulation of
>    ->commit_end in init_hdm_decoder() safe. However, rather than rely on
>    the subtle rules of CXL hardware, just make the implementation obviously
>    correct from a software perspective.
>
>    The Fixes: tag is only for cleaning up a lockdep splat, there is no
>    functional issue addressed by this fix.
>
>    Fixes: 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper")
>
