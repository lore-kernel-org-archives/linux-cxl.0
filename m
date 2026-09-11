Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E920617DFFA
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147333; cv=none; b=jLdhf/xoX4n/NtzeJgwbrFlnknYz2udSmNmTIt5UI5EXLRHCkMWyqu2e0KARsyqs+OOv6MsZXv5c9LZ8ca7B2n/6c49L/UVDmGxa6p0MI7nGZkcDkrmhTXWX7lO5tjv6LYsc2CgoaYriDnqrUqwqImuprOibymmNMHwIouo3eDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147333; c=relaxed/simple;
	bh=ScF2DTjYib54ZTTHlWWJDXI/SjWpmwO/sR6QuCBrrTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O6RJ37boYnjZiLIbkXz4F9aLsADAvo5m55nYy+UBH+r4t56OfAdrvaMeurl+Np8g+36w8g8699t4P3pmQ7E1rX0YkP+E6yGicjpJe7acdhICKFEknA84FNEh/c/01FTGaf35abiiJyLpjrVwSHSL7HG2fb+O3hsrsupXd3WGXP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i17ibuXp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i17ibuXp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789147329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qxzIq0dDRHbpRiz+JBwTZxiBX/UCvMhcRYbh7SMohqU=;
	b=i17ibuXpNiLdp3xJSHJGNnjYSk8glrxvaYhvKAfDw2PsU4/HCutukJWnG8hchnYwj6VgSF
	Rko0qww5l5M6kgKFcrpW2XTEnEd6chF7s5XpgmHOB7oYlnA94EGPkmCjdrZnrrApBEUfwN
	XNGKUfk+fnLUpSi1mZpATzKwjD/cQ1k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-nqM11wMaMm6e4AF5bMBGSQ-1; Fri,
 11 Sep 2026 13:22:08 -0400
X-MC-Unique: nqM11wMaMm6e4AF5bMBGSQ-1
X-Mimecast-MFC-AGG-ID: nqM11wMaMm6e4AF5bMBGSQ_1789147326
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86A491801375;
	Fri, 11 Sep 2026 17:22:05 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.222])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D04B0195608F;
	Fri, 11 Sep 2026 17:22:01 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	Kevin Wolf <kwolf@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Eric Blake <eblake@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lukas Straub <lukasstraub2@web.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	linux-cxl@vger.kernel.org,
	Jason Wang <jasowangio@gmail.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 0/6] qapi: convert remaining "simple" intro sections
Date: Fri, 11 Sep 2026 13:21:54 -0400
Message-ID: <20260911172200.227914-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: JeAboSoWUL_Cxko_-v66jY-EaVtPYMb6fXS9HvW6gNU_1789147326
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello, this work converts the remaining "simple" intro sections in the=0D
QAPI schema to use the new syntax. This is part of our ongoing effort=0D
to add the mythical "inliner" to our generated QMP documentation.=0D
=0D
This batch covers structures that *are* likely to be inlined, and thus=0D
have introductory paragraphs that are quite likely to be omitted when=0D
the member documentation is copied into other contexts (e.g. as=0D
arguments for command documentation, or as members of a branch for=0D
commands that accept union arguments.)=0D
=0D
"simple" here is a non-technical distinction that means a single=0D
paragraph of text followed by an existing section boundary that=0D
naturally already delineates what comprises the intro.=0D
=0D
If you are a non-QAPI maintainer who has been CC'd on this series, you=0D
may wish to review what information is being codified as the "intro"=0D
(The indented paragraph) and keep in mind that in the future, this=0D
text may not be visible to the end-user reading our QMP documentation=0D
if this structure is utilized as the 'base' for another struct, used=0D
as the arguments for a command or event, or used as branch of a=0D
union. This series keeps it pretty simple, and every conversion herein=0D
is being codified as "the intro", i.e. "not crucial to understanding=0D
the behavior of the members of this struct".=0D
=0D
This is the last of the brain-dead, simple conversions apart from any=0D
new cases that may have been merged during the development of this=0D
series. The remaining patches all convert or split longer paragraphs=0D
and require more scrutiny.=0D
=0D
We're almost back to reviewing actual code! Hang in there, everybody.=0D
=0D
John Snow (6):=0D
  qapi: convert remaining simple intros for block-export.json=0D
  qapi: convert remaining simple intros for cxl.json=0D
  qapi: convert remaining simple intros for machine.json=0D
  qapi: convert remaining simple intros for block-core.json=0D
  qapi: convert intro sections with "TODO" markers=0D
  qapi: convert intro sections followed by notes/examples=0D
=0D
 qapi/block-core.json   | 45 ++++++++++++++++++------------------------=0D
 qapi/block-export.json | 19 ++++++++----------=0D
 qapi/cxl.json          | 14 +++++--------=0D
 qapi/machine.json      | 15 +++++---------=0D
 qapi/migration.json    | 25 +++++++++--------------=0D
 qapi/misc.json         |  3 +--=0D
 qapi/net.json          |  9 +++------=0D
 qapi/run-state.json    |  7 +++----=0D
 qapi/yank.json         |  5 +----=0D
 9 files changed, 54 insertions(+), 88 deletions(-)=0D
=0D
--=20=0D
2.55.0=0D
=0D

