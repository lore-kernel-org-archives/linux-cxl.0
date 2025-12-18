Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BE836A01B
	for <linux-cxl@vger.kernel.org>; Thu, 18 Dec 2025 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073571; cv=none; b=lSm2fkWigedx5PQ7Xcn+oLOyc4enBnPoRHaWs3NR3BjfIYs/KzPMr7XQ582/+iqEGgCZX0FKPhUO+AlFjrOMKsPT4y3iqZ92yMezxzm2z6ZvAHFEoZqpaSn3TpRS/mCnE9PoAX1xMkBsuIcFj0c07VkoI+z1ITcUqOO4FWZGvlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073571; c=relaxed/simple;
	bh=bIhbOegdFRzLZEkpqXPuuks3cAwgd5SpmYiQ3VNLWVA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XBkEcO7AkVLkwJP+SJt3oLRB4zqC622bd7SzIx/KvmtQ0Fwf3oFFqqkemrygd6Jsbr75QtFVMur3tQ1t0mk2jS3fMuu4ae0Rqha91/Y6jr0bVLs6Q7kenYV3Od7AFpdWTYRIn+LWNN3TlvYgp/wQcUeYCk5b5PnAHoEhQQvElCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+VdDBDi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+VdDBDi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766073568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FErgdqg0Owcl+68IiMdBX3370S0DESPSKsYk+qF5iLM=;
	b=O+VdDBDi1sLo8tRge4AbIwwukrH7y1Gvdajkj79+eu1DLt970NIVl9FNn2RlmgQIjEwT1U
	Rtdr4lAySVXs87Rvku9T0K4x7vi/mqzrgUfMzgJsoteV8KUtOlKrNKOxiH8KnrSodAfs6k
	utYi7BbNy9UsauahmdodFqRBs1YdF5Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-m70ZaGMIOL-DMHb7eywSVg-1; Thu,
 18 Dec 2025 10:59:23 -0500
X-MC-Unique: m70ZaGMIOL-DMHb7eywSVg-1
X-Mimecast-MFC-AGG-ID: m70ZaGMIOL-DMHb7eywSVg_1766073561
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC6FA1955DC5;
	Thu, 18 Dec 2025 15:59:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19A1B1956056;
	Thu, 18 Dec 2025 15:59:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id A380F21E6A27; Thu, 18 Dec 2025 16:59:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,  <ira.weiny@intel.com>,
  <alucerop@amd.com>,  <a.manzanares@samsung.com>,
  <dongjoo.seo1@samsung.com>,  <mst@redhat.com>,
  <marcel.apfelbaum@gmail.com>,  <linux-cxl@vger.kernel.org>,
  <qemu-devel@nongnu.org>
Subject: Re: [PATCH 3/5] hw/cxl: Allow BI by default in Window restrictions
In-Reply-To: <20251218154832.00000159@huawei.com> (Jonathan Cameron's message
	of "Thu, 18 Dec 2025 15:48:32 +0000")
References: <20251103195209.1319917-1-dave@stgolabs.net>
	<20251103195209.1319917-4-dave@stgolabs.net>
	<87wm2ki1wm.fsf@pond.sub.org> <20251218154832.00000159@huawei.com>
Date: Thu, 18 Dec 2025 16:59:17 +0100
Message-ID: <873457aii2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Jonathan Cameron <jonathan.cameron@huawei.com> writes:

> On Thu, 18 Dec 2025 10:18:17 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Davidlohr Bueso <dave@stgolabs.net> writes:
>> 
>> > Update the CFMW restrictions to also permit Back-Invalidate
>> > flows by default, which is aligned with the no-restrictions
>> > policy.
>> >
>> > While at it, document the 'restrictions=' option.  
>> 
>> I'd split the patch.  Up to you.
> Hi Markus,
>
> As you note below the interface hasn't been in any release anyway and
> is part of the long backlog I'm carrying and slowly getting
> upstream. Bringing this in from the start with that restrictions
> control should be fine.
>
> However, backwards compatibility does need addressing
> as this changes the default for things we do create today (with
> no restrictions).
>
> In this particular case, I don't think we care because there are no
> BI capable devices before this series - so there can't be anything
> using this feature for the host memory range it describes.
>
> As such, the only result is the ACPI table says we have an extra
> flag set which no one will care about.  Will need to update
> the ACPI table tests though. I'll check.
>
> Migration of CXL topologies is horribly broken currently anyway
> so that's not a problem here. Given current usecases are strictly
> software stack verification fixing that isn't a priority (yet).

Good to know.  Work into commit message(s)?

