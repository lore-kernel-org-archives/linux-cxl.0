Received: from cornsilk.maple.relay.mailchannels.net (cornsilk.maple.relay.mailchannels.net [23.83.214.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FAC29B8D3
	for <linux-cxl@vger.kernel.org>; Sat,  2 May 2026 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777751612; cv=pass; b=mP9MlQ1VOoXy8pRJu5YOgs3A5A0TjqO09wib01QBs9B9yeubY/hafdbdV4BqfnH0eJyOL1gbb5YiXOMTeMNrRhkLoObB5mb4xsIPm7T0kC7hlG4aO5RrKzRkEy53rVBVY4iDUN66CgC6oU1CRRL2MkvbXic/IHFD8wrNAjEdPpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777751612; c=relaxed/simple;
	bh=/ZohHdZoglrAXnRAqE/+hY20SfF3v/Z9qhXA5ve/WX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4hCw20gAW46Ozvdmbxz+4Z3FX6iMSMwdC7dulONNcOagtPW5Y17Eyw9GT08V0jYG/rf3lLd+dvSCh8E0zTHm/7HDVKpQ5isG4wcGMd4v7p3nAeUNH8TbUzlvTKLEOr5emUSosLVcMv5Iv3ZAsQ7PpvPLSf3S6kzH37+QWAM5YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=nh6dFG+6; arc=pass smtp.client-ip=23.83.214.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="nh6dFG+6"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8FE7E721161;
	Sat, 02 May 2026 19:34:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a229.dreamhost.com (trex-green-6.trex.outbound.svc.cluster.local [100.97.142.130])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2C8DB72132B;
	Sat, 02 May 2026 19:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1777750483;
	b=FJcdQqbtscSA9g0AyXg8aQdqFzhjg9j5JIQjtAlQrIxjSxjdn9W/0DmY2S4ecu+SuQKxJx
	J8UdMVILsypp831GQFPjp8yU4fDJIUGDiQM2lptFnD6q3vvdiAnfVIXNj4JAC2G6jsfmER
	6kQANREIs0NH7CDFaMCWoWZtYHT1VHMLTPi6Oo62xDNtQPSDm8YKsfL3jcI0y9Y8mNYbns
	It6p/BAVbmeGTxS6A9OD0w09w9Xe/ijDf35h/3Cg4oj2NAQIcNtvTjY+G4nznZDAyIPI/x
	OZhJz1vcaoMh6QBw2BkYnI0Mz8PicwujXUMBJEEGoJSSPyKdO4RprTPKow1+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1777750483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=1CKy+pRbfHAM2EQs/oXLaDkxHYa7jjcSO+CG5Q9KCTQ=;
	b=qYhXpRuzwCg/ZHphg0i0uo0S+Eo839pagX28VrZ8rMhbFf/G6vMI/YmjNBjl8MEjiqgwnl
	r0EIi/vLpZjfQRaxg3xGH12G9t2c2kzF02Iz3nj/SMj1p6y7HwzpC6f+X7r+m8Mst+5FhC
	rwQAvniO/+D0g5MnGfGgKylv+oTCqa3fPbrMqKnEXuKFnh/oz/EYzSD9lvk2q5RTlp7nN8
	uj8zXr1RhOMgU3V3qcdlw/307CqEC+AAYSpMIzBVLspyNUoUdiJHeGCx7dRLnD51G1jjJe
	53pWh1VhwDe8TyT/uZbynLUy7R/jDmksG+ITZa9xXbqywH4S40BNOyuLfGtwHg==
ARC-Authentication-Results: i=1;
	rspamd-859c89884f-7g82c;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Thoughtful-Harbor: 09ad185372278d4a_1777750485393_628780005
X-MC-Loop-Signature: 1777750485393:4293056259
X-MC-Ingress-Time: 1777750485393
Received: from pdx1-sub0-mail-a229.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.142.130 (trex/7.1.5);
	Sat, 02 May 2026 19:34:45 +0000
Received: from offworld (unknown [172.56.204.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a229.dreamhost.com (Postfix) with ESMTPSA id 4g7J5F1MctzRx;
	Sat,  2 May 2026 12:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1777750483;
	bh=1CKy+pRbfHAM2EQs/oXLaDkxHYa7jjcSO+CG5Q9KCTQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=nh6dFG+68NVfHNk2YXO5u0Ogbk7aICWAgdCWCE4z+IbADePPmHiAHTE7Wkgj+UvOg
	 dzmDuYJaiedqbeSDjuV05D1iRPdFXc/hERD58L9JBaJM7Vvq9NmwZfj4GKGyftkWsd
	 Z7vAKenBDWAprxyLWT8Cj35fLIq2MfcHKoItEY6bbOdLZqfGhGuiU3in+i2+6MuG/N
	 j7H4+TVfh2/BXy+Yoc0Tnnjptq1pU6nS2cfDc2skP50fOG8qS4J6KuZhTEHetpCc4X
	 dRqhxXYrp+GlzJYIzFi1FEBH7wd5VgIFL57tBH1xHT0PxQ9G/hqVIR8qsvw7e0pOWV
	 T7Pn+/k9ATiEw==
Date: Sat, 2 May 2026 12:34:29 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: jic23@kernel.org, alison.schofield@intel.com, ira.weiny@intel.com,
	djbw@kernel.org, dongjoo.seo1@samsung.com, anisa.su@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/mbox: Support Media Operation
Message-ID: <20260502193429.hztbijgv3bjwit5k@offworld>
References: <20260428200410.705675-1-dave@stgolabs.net>
 <1999de6e-7f14-41d2-ace2-db00faede674@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1999de6e-7f14-41d2-ace2-db00faede674@intel.com>
User-Agent: NeoMutt/20220429

On Tue, 28 Apr 2026, Dave Jiang wrote:
>> +What:		/sys/bus/cxl/devices/memX/security/zero
>> +Date:		April, 2026
>> +KernelVersion:	v7.2
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(WO) Write a DPA range as 'start length' in bytes to this
>
>Same comment about multiple input in a single attribute. Maybe introduce these:
>
>security/zero_start_dpa
>security/zero_len
>security/zero

I had missed this feedback - this suggested interface is horrible. While the
sysfs documentation mentions the one rule per file, this is not strict and
(as Jonathan also agreed previously) we can do <start> <len> inputs. There
are plenty of examples that do not follow this rule when it makes sense.

So my follow up patches will do

echo <start_dpa> <len> > /sys/bus/cxl/devices/mem0/security/sanitize_range
echo <start_dpa> <len> > /sys/bus/cxl/devices/mem0/security/zero_range

Thanks,
Davidlohr
