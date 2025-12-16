Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2BA3090C6
	for <linux-cxl@vger.kernel.org>; Tue, 16 Dec 2025 06:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765868020; cv=none; b=bCnX9uAjYVn7n/2Et2mLAXtiq8tR4lixEhznVC7x/EDXFL6PUB1mR0f3oQPiRXHR0rMh6wUUYnJvBP+C7WWKdKwi6Ypy4KNXDpTA44VvahRsJEQgHU2yiri8yYbfXgjdY8bkdRymLj2nR7bUwPSlHZ1Z4kWCM5Iyp89PU7+8/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765868020; c=relaxed/simple;
	bh=ONPiWzqQSCdz6p25qZ/k2qMqIcF0Cp8fP7jn614vxYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JvYxZIqHOKdxL3KIx4cwHw8J5lcMahmJ/5UhpkP5uis/EV6W72j7V+Ay6wO+/gtO+xPJsAe39q3BH5Hho55vgbD81+6EjSwWlJnip28Y5TR7AR3f4XQIeogbrde5qrS9dgZr52+mmzF2q0ZNGltvB8LlIyQylJnSWI1m27QMAfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i11bqRHx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i11bqRHx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765868015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ONPiWzqQSCdz6p25qZ/k2qMqIcF0Cp8fP7jn614vxYc=;
	b=i11bqRHxrHskWn328vu/bFY/F68PeMyVKu9xB7/fCAfFntgu3hbjnNogpiWbGKUEcLfyac
	eYvSYA0mz+1Qra4YmnmciHTuVgHixmpb+T2rxQXEymBMJuiERd6M/m8S7FwCQyt5YAHONh
	7AGNk6TOz4gLWBhvkRVfXL8smGv18qA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-9h0lfH1PO9uqPaAOI62Azw-1; Tue,
 16 Dec 2025 01:53:30 -0500
X-MC-Unique: 9h0lfH1PO9uqPaAOI62Azw-1
X-Mimecast-MFC-AGG-ID: 9h0lfH1PO9uqPaAOI62Azw_1765868008
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F09B1801211;
	Tue, 16 Dec 2025 06:53:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 642C819560A7;
	Tue, 16 Dec 2025 06:53:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 1121421E6A27; Tue, 16 Dec 2025 07:53:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com,  ira.weiny@intel.com,  alucerop@amd.com,
  a.manzanares@samsung.com,  dongjoo.seo1@samsung.com,  mst@redhat.com,
  marcel.apfelbaum@gmail.com,  armbru@redhat.com,
  linux-cxl@vger.kernel.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v4 -qemu 0/5] hw/cxl: Support Back-Invalidate
In-Reply-To: <20251103195209.1319917-1-dave@stgolabs.net> (Davidlohr Bueso's
	message of "Mon, 3 Nov 2025 11:52:04 -0800")
References: <20251103195209.1319917-1-dave@stgolabs.net>
Date: Tue, 16 Dec 2025 07:53:25 +0100
Message-ID: <87cy4esysa.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Davidlohr Bueso <dave@stgolabs.net> writes:

> The following allows support for component basic back invalidation discovery
> and config, by exposing the BI routing table and decoder registers. Instead
> of going the type2[0] route, this series proposes adding support for type3
> hdm-db, which allows a more direct way of supporting BI in qemu.

[...]

> Applies against branch 'origin/cxl-2025-10-03-draft' from Jonathan's repository.

URL?

[...]

