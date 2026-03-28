Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C52783A14
	for <linux-cxl@vger.kernel.org>; Sat, 28 Mar 2026 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774677724; cv=none; b=XqJgnrPeJaUUqXsZ8iQT+lxpEFAv8VWknbyt9Wn74PlKsfP0Xp4EraHVaHzL9i9ptYib/Mf/lfh6Extn9hOspqq1Z9KLZHf2TAQQX3Lc93ufBXX4juOE08tWm1VOfl7Wc3AnMdDJnZQ4M/L0TLDCoIDj+MKjeRBAW2CS+/DJaos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774677724; c=relaxed/simple;
	bh=HQvREEeEfU0eREdXkyLooYyQCzQdvXnGvKCNU5uCkXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i/qMufzrBaZ7kYW6y30ctAWB4nkL1jeagYza75p738ndePq+Dk8LR0QB0fd+fwmvlD8RyISA1ZMCZY2ssGLZ3TA6NpWpCAv7ysv+toJ09pofdWswPVK0P560AYRJNBkEMOyZyKoyDNRBP5Nrld+eSeQbY6sCTUuyd7wv1JvDnVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZuDggVp9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuDggVp9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774677722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LOl67eVYjM6XwA+2aoAT/RR6VujgC2WWk7a6aW7H6AI=;
	b=ZuDggVp99Z7LgOLNPmqXCggHXhuT+gJmUx7Z8UuQ13Yqv6Qo5vyECXdOTIJJ9OaaU+9tvr
	drzVUu0MDcFTcg+CNdbJIx4HGp2Hu6IqyHliUsf9C3LIepB9ygojUX3Dvu+RGjERrsRQVa
	OeQ6t8QerFAd2oBktPRfDX5/Jr5WdWg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-QK3TLCZJNl6B8duKTuTrnw-1; Sat,
 28 Mar 2026 02:01:56 -0400
X-MC-Unique: QK3TLCZJNl6B8duKTuTrnw-1
X-Mimecast-MFC-AGG-ID: QK3TLCZJNl6B8duKTuTrnw_1774677715
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA6AC19560BB;
	Sat, 28 Mar 2026 06:01:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 803171955D84;
	Sat, 28 Mar 2026 06:01:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 291A021E6937; Sat, 28 Mar 2026 07:01:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <anisa.su@samsung.com>,
  <berrange@redhat.com>,  <eblake@redhat.com>,
  <jonathan.cameron@huawei.com>,  <linux-cxl@vger.kernel.org>,
  <linuxarm@huawei.com>,  <lizhijian@fujitsu.com>,  <mst@redhat.com>,
  <pbonzini@redhat.com>,  <gourry@gourry.net>,  <nifan.cxl@gmail.com>,
  <me@linux.beauty>
Subject: Re: [PATCH 9/9] hw/cxl: Add QMP status query for dynamic-capacity
 extent release
In-Reply-To: <20260327151811.00005564.alireza.sanaee@huawei.com> (Alireza
	Sanaee's message of "Fri, 27 Mar 2026 15:18:11 +0000")
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
	<20260325184259.366-10-alireza.sanaee@huawei.com>
	<87mrzuei5f.fsf@pond.sub.org>
	<20260327151811.00005564.alireza.sanaee@huawei.com>
Date: Sat, 28 Mar 2026 07:01:51 +0100
Message-ID: <87zf3s1ohc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: QVU8AEx7gJzi3SqCzZs5WKwBworqlRJd_LNT6LBApyY_1774677715
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Alireza Sanaee <alireza.sanaee@huawei.com> writes:

> On Thu, 26 Mar 2026 16:15:40 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>
> Hi Markus,
>
> This commit adds a test command to check whether an extent (a piece of memory region) has been released or not by the guest.
> The process of removal is highly asynchronous, that's why I needed to add a new command to check it.
>
> I would be happy to drop this patch, as this is extra.

So your motivation for adding the command is "just" testing.  Correct?

Can you think of other uses?

In particular, would a management application need this query to monitor
removal?

The description of feature @unstable may need to be adjusted for the
answers we work out here.

>
> Thanks,
> Ali

