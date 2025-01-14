Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F901ADC6D;
	Tue, 14 Jan 2025 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736883238; cv=fail; b=l7xtdt8O3/9bsLbqZe+DqOZNcAIek8Lr+Vso4wtmlPDYMniOHH5Bo1bOjUFsNqtJEMEIjte1YLONfBS7pRe64tjaOZU/dIAbn3t35Rv+eDndQuaoNnvXotFn21Oe9RKrh70aaLCoXTkBAk2oDwoZdVYNESr8XZvI3a7PC/f7Flo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736883238; c=relaxed/simple;
	bh=R7T7YKYLZVULmflOZOUk59kPUUY7+pfzRJKazMbo7KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4L9oITiBEdc9keSN+llIm1dJhwJLuDixU8BkO0t4vFs8WHtz4M/uq0mStouf+wLPN6YqRDb2o6WRm6l6sZDkv/TlLt+aAZQnUKUCeNsEG3TyvX/sx1L2E+AAeNKT2SFHDmsG5sEJel1bcFNzl4WftNWdSL4YWVvf2qIy+Tg95Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=e0vtJBr2; arc=fail smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="e0vtJBr2"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F3E118A51EB;
	Tue, 14 Jan 2025 19:33:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a288.dreamhost.com (trex-0.trex.outbound.svc.cluster.local [100.109.200.77])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6574C8A52F8;
	Tue, 14 Jan 2025 19:33:48 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1736883228; a=rsa-sha256;
	cv=none;
	b=haOOEGWE0WY7ENQ+hiNFz3R3p/f8C6NyAz9G7i67CQ+B0nYlTDnK6klIVTon9msfzlTVuL
	PU3W2ifgeRg/rQ/dpbrffq9PQhUOtCBcgvpQMNb8v1keJRHlJxfNIMMLa1jJHhG/+iueO2
	2aD/HsfqLJot5fregBNv6TVNWLonKapYO53QYHbOHuHpgnINpSElQMr2BajEy4ff3F3A3H
	bo5PL59Mw1F/OIpAsreghi+Tf0bH4T+WCpU2gvN51zzuo7tA+Ta+5x7HNrwaOnLR6eGm7V
	v+GE5ngqu1Zrdzc8qxB8LhSc+fXaZK63LklMzydWMHnWtleORyfl2qFcx/ohJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1736883228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=jYu2oJOcWiWlCQ7GQEVYIZ4fGmZ5hNfOO2syhk3LetE=;
	b=cslCxajxD8LmzCI7TKZNjaIb5M4jka6oYe/qZNzpxJ6rtE6U9chbqsUONRUdRIO0GnYYYm
	0HGGRhy+S4EfBByaCBis5lwfBdkJwdAppAKQHlIHWz3Ku1JMhNyCBL88XNt6k+bY6gainN
	0CmSSGwuewcaQzaX4eirKrofFtgDum9uGsS/ZtQHG/NZ2NSlkiWBxk3in4T/MApSJXBDSM
	oQ8YnWTQehQBCV+XUATUT9Wn850Jw2ixXHbvucu+oAiXFr/qlRTSu1zum7qryMM1ABTJJW
	M36g/4SzskA5ZDLZQ/d53rTOBSjuUgxrfpK72/50p22NDjtnM6z810SGfmm3uw==
ARC-Authentication-Results: i=1;
	rspamd-b5645c5d4-wstkz;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Supply-Left: 60e5634f19e37ce7_1736883228728_2581126656
X-MC-Loop-Signature: 1736883228728:1554256537
X-MC-Ingress-Time: 1736883228728
Received: from pdx1-sub0-mail-a288.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.200.77 (trex/7.0.2);
	Tue, 14 Jan 2025 19:33:48 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a288.dreamhost.com (Postfix) with ESMTPSA id 4YXfSW2LD6zDF;
	Tue, 14 Jan 2025 11:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1736883228;
	bh=4GfoDnQZJQpHug2bFq7YQ4GDDxY5NcDebd6e9aECI9U=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=e0vtJBr2Oo+Z/2ZsZhQVf9n0fP4KDONQ4IU2lhaRgQeV/yFwleY240i4Sp4XFESPr
	 ALqvzBYJyM4jly7jbCf6CTL2mxkf9CnoOmw3MrIPszHZqYdtIB65X4qWpkIHSd3DsK
	 XGyyWDd1D7+zhiuEU0lcp1qcSmn8SHZ+4zxGwFBUgLfscFoFcZb+TWbeJRhFPIqfKJ
	 3f+XUoC+ScHh5qZnPnzHn/osKTfP+GCWhjl4kgmgnUjZETWRBSYEahiAjtYT8dXP+R
	 RhlkyYRS1+JsgyOSciKdXCYavfru7ZQuR+k+Ya+gmRXKl/dhXFvkqbJM6Me1OPQaEZ
	 3XvFxENRXW+eA==
Date: Tue, 14 Jan 2025 11:33:44 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: dan.j.williams@intel.com, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, fan.ni@samsung.com, a.manzanares@samsung.com,
	sthanneeru.opensrc@micron.com, emirakhur@micron.com,
	ajayjoshi@micron.com, Ravis.OpenSrc@micron.com,
	sthanneeru@micron.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cxl/mbox: support aborting the current background
 operation
Message-ID: <20250114193344.jswodb44wupxx4a3@offworld>
References: <20241022031809.242591-1-dave@stgolabs.net>
 <20241022031809.242591-3-dave@stgolabs.net>
 <7e390255-7e55-4b59-9a7d-6aa3857c8a42@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7e390255-7e55-4b59-9a7d-6aa3857c8a42@intel.com>
User-Agent: NeoMutt/20220429

On Tue, 14 Jan 2025, Dave Jiang wrote:

>On 10/21/24 8:18 PM, Davidlohr Bueso wrote:
>> CXL 3.1 introduced the ability to request that the current on-going
>> background command be aborted. Add support for this, where the current
>> policy is for the request to occur whenever a new incoming bg command
>> wants to run. As such everything is left to user discretion and it
>> becomes impossible to hog the device/mailbox.
>
>Are you trying to say that the patch is changing the current behavior to where every time a new bg command comes in, it will abort the previous one?

Yes.

>
>>
>> The context of doing the cancellation request is the same as the new
>> incoming command, and will always hold the mbox_mutex, guaranteeing
>> that any successful cancel does not race with a third thread coming
>> in and stealing the effort.
>>
>> - For Sanitize, the thread doing the will cancel the work, and clean
>
>doing the? seems to be missing a word here.

'doing the request', will update.

...

>> +/*
>> + * Return true implies that the request was successful and the on-going
>> + * background operation was in fact aborted. This also guarantees that
>> + * the respective thread is done.
>> + */
>> +static bool cxl_try_to_cancel_background(struct cxl_mailbox *cxl_mbox)
>> +{
>> +	int rc;
>> +	struct cxl_dev_state *cxlds = mbox_to_cxlds(cxl_mbox);
>> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>> +	struct device *dev = cxlds->dev;
>> +	struct cxl_mbox_cmd cmd = {
>> +		.opcode = CXL_MBOX_OP_REQUEST_ABORT_BG_OP
>> +	};
>> +
>> +	lockdep_assert_held(&cxl_mbox->mbox_mutex);
>> +
>> +	rc = __cxl_pci_mbox_send_cmd(cxl_mbox, &cmd);
>> +	if (rc) {
>> +		dev_dbg(dev, "Failed to send abort request : %d\n", rc);
>> +		return false;
>> +	}
>> +
>> +	if (!cxl_mbox_background_complete(cxlds))
>> +		return false;
>> +
>> +	if (mds->security.sanitize_active) {
>> +		/*
>> +		 * Cancel the work and cleanup on its behalf - we hold
>> +		 * the mbox_mutex, cannot race with cxl_mbox_sanitize_work().
>> +		 */
>> +		cancel_delayed_work_sync(&mds->security.poll_dwork);
>> +		mds->security.poll_tmo_secs = 0;
>> +		if (mds->security.sanitize_node)
>> +			sysfs_notify_dirent(mds->security.sanitize_node);
>> +		mds->security.sanitize_active = false;
>
>Should this line happen before the sysfs notification?

It is benign as we hold the lock, but yes. I will also abstract this in a helper,
such that both cxl_mbox_sanitize_work() and cxl_try_to_cancel_background() can
use it.

Thanks,
Davidlohr
