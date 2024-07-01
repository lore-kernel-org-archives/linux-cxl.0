Received: from cockroach.ash.relay.mailchannels.net (cockroach.ash.relay.mailchannels.net [23.83.222.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239631EB2A;
	Mon,  1 Jul 2024 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850012; cv=pass; b=NDDzLFgh0KUMWEzcagf9G/JZ//47FxLiBXDaXBM0crS8K6Yi953lGZNKI0J3AZbBvmRpRE7mWYvrqr0r38XfWCnMZip06PFtXjEcwQvyxImM86QfMzItmWq3XRZHylcZGhwu39w6UOATdTLbEDcPOH9v+rSOkOBcORF5HTQgVGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850012; c=relaxed/simple;
	bh=Fmfy/xanfD84Dr+3FY7udGrsBHHaal7DeaKVvneRcQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujqJCJdjYtWqNcZtOks2dsaEEcPCOzt81g5EzAXKUEJkpqXrdKnwnlST/M0TDOiqashvxz0eRSACEyrRBWSuAQObZsW4Mn0otVwe7tpBX8q/RMqn+AGmfpraj+ebSydRLG+HYGpe1YQM3Ca6WSKrtgfJPWsNU5Dm6Cdl1MesSf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=GbO6gM1T; arc=pass smtp.client-ip=23.83.222.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="GbO6gM1T"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D2A325C0F88;
	Mon,  1 Jul 2024 15:49:36 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5EBEC5C1B6A;
	Mon,  1 Jul 2024 15:49:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1719848976; a=rsa-sha256;
	cv=none;
	b=K3vskIPsaEkbKlZ+39JXhK2UUI9c/I3mL84BX9hqW/MatdflI6hMygskfFIILcGFVUMLHb
	DsaLsVfmmWMe2L8pOkMT3cvuuucNtBB/CFwS/N+urnbaMe90kAJCHgDgx1PZPLIo3vH+JT
	774vGH7aqG3Ya1x2zyqBRYJo+0OOLcWxnrYtns5S8ddCQZQWy87EtvCfzzSs49BsI1tAhx
	R7x2QbO4qic2iGRLIc/dk1H0gTHwOGCyRCQY0/uYMCUYxWfLngybshkrW6kY31NVASrNlk
	tVi4NFff2eLK5usRIHEIgvXucirX7M+5nWGhGtz0AL25tXtDDDi4ORMFoQZjLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1719848976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Fmfy/xanfD84Dr+3FY7udGrsBHHaal7DeaKVvneRcQ4=;
	b=M8RCE8/eGI+8lYvaBh9/XG4LZtfhlorho7k8uust2TmjWqFZ7djUm5JMiZkW4pFkhO9gX/
	oopT+wlqQDrfyV00tkpANt/ItefZ++fq/CQ+KQnDEEwDKXQkjq4QofcIXyI00zrBvyWpxa
	jo1jLDUdf97EONHenuAVimJxlEgMBSMUJNNN9WtFDdkBe9ylZ/Ovg2O9kapcGRHOrFh2eW
	H8F5WiLO6FmlYTBgeVO0y0G24+nkCqalAAqPnCWxuOzc9/6YzP/UOSCz6eb/tII9Z1hU+k
	0+nbcK71431LPCwdBZhJ2VEl5koHjE//83Zra6x0vew838l/zCQ82hxd2k+qGA==
ARC-Authentication-Results: i=1;
	rspamd-79677bdb95-txlxl;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stupid-Relation: 0e9670cc4fdd7ace_1719848976681_3504571096
X-MC-Loop-Signature: 1719848976681:2275360465
X-MC-Ingress-Time: 1719848976680
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.90.83 (trex/6.9.2);
	Mon, 01 Jul 2024 15:49:36 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4WCVpl55DTz5y;
	Mon,  1 Jul 2024 08:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1719848976;
	bh=Fmfy/xanfD84Dr+3FY7udGrsBHHaal7DeaKVvneRcQ4=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=GbO6gM1TUlIgx0XWcNmx8hQX4Uwm9UOl6c8eklzCcOncOSox/lpk8Ihk4/BNrfZJm
	 RfLL1BjXNuVK8jaRnfKR0Xd6x2n+D3pB+ezdUdEk5I3KLsUCvoXOiGEYPg6Ktwhgzq
	 zambJdDfJ3hL/MO+VSiejOMg7FqU0W4zHvhvV55lPMKeGqBFk7oNnIRhMUtkV12EEf
	 zJjYgd3jKp1iTFpW2y3jyFblToD8YEp2AToRlpLZ2l0tjq6uIqjivpJbQ0GSAewxwJ
	 faIkasgt9BrmuEF7AkmuAo0NzKd4mHlCwatbk1BBxFBdF6EkmMhjB7qeLMW3ZF4+EF
	 KN00jJMBNkJRg==
Date: Mon, 1 Jul 2024 08:49:32 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/acpi: Warn on mixed CXL VH and RCH/RCD Hierarchy
Message-ID: <20240701154932.ch7b75m5xp62oly7@offworld>
References: <20240628175535.272472-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240628175535.272472-1-fabio.m.de.francesco@linux.intel.com>
User-Agent: NeoMutt/20220429

On Fri, 28 Jun 2024, Fabio M. De Francesco wrote:

>Each Host Bridge instance has a corresponding CXL Host Bridge Structure
>(CHBS) ACPI table that identifies its capabilities. CHBS tables can be
>two types (CXL 3.1 Table 9-21): The PCIe Root Complex Register Block
>(RCRB) and CXL Host Bridge Component Registers (CHBCR).
>
>If a Host Bridge is attached to a device that is operating in Restricted
>CXL Device Mode (RCD), BIOS publishes an RCRB with the base address of
>registers that describe its capabilities (CXL 3.1 sec. 9.11).
>
>Instead, the new (CXL 2.0+) Component registers can only be accessed
>by means of a base address published with a CHBCR (CXL 3.1 sec. 9.12).
>
>If an eRCD (a device that forces the host-bridge into CXL 1.1 Restricted
>CXL Host mode) is attached to a CXL 2.0+ Host-Bridge, the current CXL
>specification does not define a mechanism for finding CXL-2.0-only
>root-port component registers like HDM decoders and Extended Security
>capability.
>
>An algorithm to locate a CHBCR associated with an RCRB, would be too
>invasive to land without some concrete motivation.
>
>Therefore, just print a message to inform of unsupported config.
>
>Count how many different CHBS "Version" types are detected by
>cxl_get_chbs_iter(). Then make cxl_get_chbs() print a warning if that sum
>is greater than 1.
>
>Tested-by: Alison Schofield <alison.schofield@intel.com>
>Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
