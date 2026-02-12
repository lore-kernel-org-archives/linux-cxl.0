Received: from dog.birch.relay.mailchannels.net (dog.birch.relay.mailchannels.net [23.83.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2A8E573;
	Thu, 12 Feb 2026 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770920018; cv=pass; b=nOKRjScKM0Nm/T/ERAbVWF+aoWG8hacOYtMYd/WNyYPZLutdEZnSbUZhHH/EleC4rQWoEuqVztw28EqQPgD5dMTPEv8w5xGVws2EhnDhl1lcDk1nc+F7xKKZkZeq8THBg93MyhRSYQP5LrW7eUDl3XeNzWJL5LVmzsZUxZfxIQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770920018; c=relaxed/simple;
	bh=bHR+3mTixf9RIK5Gzvd/naYnT/4uOy0tnO1nYcYmufg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/gyu+toTKUiH9lPBojYV0EQcRcfStirBITlr9uXf6jkbJ3nwo0Qs36F9UQEq3QbN64BaUQwsc7LkIEhSjraO3iYGqs9H8CGz8TcWc5eePDzROt2b4DVwvi2g+itgLOjf1CDtR46TU25fxAd3N50mWbqChAfFia/kJVt99PMjis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=gZLUv1CQ; arc=pass smtp.client-ip=23.83.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="gZLUv1CQ"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6EDBF8A35AF;
	Thu, 12 Feb 2026 18:13:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (100-99-24-1.trex-nlb.outbound.svc.cluster.local [100.99.24.1])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5BBAC8A25AD;
	Thu, 12 Feb 2026 18:13:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1770920009;
	b=vfx1qrAaTP7mU0oouY/MzUT93SC5Yykx1Qg8J/kdjmS6KjkOnXoWkKrZ/afbdaEx8SiMNT
	KgWFYSQZ5fYVaxy4PwB8ljDrY5UTYa8vBxpMqwlcE4oBaeVwo19170bXk2og2caSDdkunX
	BOGHKOsnU2BZunlgWYXSh8YSui5mBrmbcu37kUQ9NCD3NI7gGVAfbsnsyZ3GhX0DZverPf
	NCC+YW/pSyOEUlhB2kdh52tub7z27m2iZymucEoB+IfDw0wofJNS1uJkU8pDWKyPveVXns
	QXorPvf8yj3WuNWxFWgPDPFUKmCk7hxzfURDFp09YEUuLIa9r1MU6+qd5ADGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1770920009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=bHR+3mTixf9RIK5Gzvd/naYnT/4uOy0tnO1nYcYmufg=;
	b=nd1rytp4Y2/RJZI5AhcR6xSJb6q6bctiJHggxTnP9CRzvSBLYUEZIbIOzX9V8jT8oCMaWD
	KfVx9zCCszleqGmx++XJbiZEMrsfvCFlnxOlrnmiMcXDRF/t45C8jBi3saHvuzyaaWAid3
	5d3EcvniqDRb5266wyyLMauAneWhuYFUEroEG5XGsDIjC4S95/CIIgaIihCuAYmqE9Wg+l
	sws+VA35IUccFpk9i+cpV8rO0MBzLa9Ul8MVZkG6bAk/acDZ3/pwsfQnh98pNWTBGllNA9
	eSrXFkyUN2T19pE7/gPwkOvpsdMwNGjT5Sky325SWUTXB+WR2X8RMgHegyY/BQ==
ARC-Authentication-Results: i=1;
	rspamd-79bdc9947c-c6d9t;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Hook-Quick: 17df99992162422a_1770920009714_4065537010
X-MC-Loop-Signature: 1770920009714:1590538124
X-MC-Ingress-Time: 1770920009713
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.24.1 (trex/7.1.3);
	Thu, 12 Feb 2026 18:13:29 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4fBk202PVdz107M;
	Thu, 12 Feb 2026 10:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1770920009;
	bh=bHR+3mTixf9RIK5Gzvd/naYnT/4uOy0tnO1nYcYmufg=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=gZLUv1CQ0/sZcTakI0kU+sQvSPTJ19ODGSpC1dwM3DI2iOnpHBBPta79pfHu+PxtL
	 tjeEjOT3Af5qI2hzeFymu5TRcjLDQwtAucf8zEijP1xRaDTfJ3BICbeaIJ+8UcV03Z
	 ahDYj6GusuQdlYwd5UgtfqIvvo7Mk63Y3VXatWPQZdqW4/DL/vSjhn2/bOuzQwSxBd
	 sTD0ZCONZsKqUalsrUFk2xMd4HeeWUo7rxtXwmjxyHPv+8GrFNLojOB2pGMDyzr39M
	 z1bzHQKDrZN6Jyp1HkcVGEzulTdg1bHEFfY0ZgmUYI0EG2E7FRq9VAoqz9uXAinuAM
	 vccX3mKZTvPkA==
Date: Thu, 12 Feb 2026 10:13:25 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	david@kernel.org, osalvador@suse.de, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH] mm: name the anonymous MMOP enum as enum mmop
Message-ID: <20260212181325.riolqzwvhqjmv6mk@offworld>
Mail-Followup-To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, david@kernel.org, osalvador@suse.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260211215447.2194189-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260211215447.2194189-1-gourry@gourry.net>
User-Agent: NeoMutt/20220429

On Wed, 11 Feb 2026, Gregory Price wrote:

>Give the MMOP enum (MMOP_OFFLINE, MMOP_ONLINE, etc) a proper type
>name so the compiler can help catch invalid values being assigned to
>variables of this type.
>
>Leave the existing functions returning int alone to allow for
>value-or-error pattern to remain unchanged without churn.
>
>mmop_default_online_type is left as int because it uses the -1
>sentinal value to signal it hasn't been initialized yet.
>
>Keep the uint8_t buffer in offline_and_remove_memory() as-is for
>space efficiency, with an explicit cast when we consume the value.
>
>Move the enum definition before the CONFIG_MEMORY_HOTPLUG guard so
>it is unconditionally available for struct memory_block in memory.h.
>
>No functional change.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
