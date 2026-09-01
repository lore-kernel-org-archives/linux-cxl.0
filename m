Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5A33C5540
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 19:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291820; cv=none; b=b1/Af/MSiSs1MBE0g1n/tY8OwsneS9Bv6PYvc5XeG9Xdkc/Xkn8FmbhB/imjNZ3e/i8f72SGA7rlMXHnuN9KzcCYAah6oZBVm9YguoZS7Q3dRuZSR+CT46NWgkI3zVNXSFPO2fDQC57nDz0HfywZ/jyhgkRPg7qPjXWFlpnoXRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291820; c=relaxed/simple;
	bh=fEJzyFXXxWJ3+h8Jii61HQsKnel36k8qqYoo4lYU7v4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q4U8ryq4oa/u8x2+DRwqsLFS3AB/t32QaxrSOZ/6zM6JGk3is2OkLE/PR5LNBq/osXpJUJIFsDcL+wgD8rsVM9QP06fpJiNEY8GPnakk+UJS+XA6J4qaBiKCH33VYYQuMJRY7mXSm1vLpZ6jzWhyGAWgDSsKxHbA5T4v/QHZ1Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WGjf+4lM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGjf+4lM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788291818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WPc2unno2XPrQR7klsEkdhoVxzmN2YV3nF+a6vvt4jI=;
	b=WGjf+4lMsD30v/QbbHwxqIG+R19RZdQAoJRYa4XMerkDhO6L4ntcQ73dMQks3LXroIYYJ9
	ttpB3BY425cswT/TYmSUlbH3QTQlnhhkoBdLm9XTmPpmicMKH/D1z+13g7Nv+F0a5z4LTP
	Noa9zbvy2sIyY68bkvqpLje1wQC+xbs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-xbVnYlNwOZqh5JhaHmtt5w-1; Tue,
 01 Sept 2026 15:43:34 -0400
X-MC-Unique: xbVnYlNwOZqh5JhaHmtt5w-1
X-Mimecast-MFC-AGG-ID: xbVnYlNwOZqh5JhaHmtt5w_1788291813
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 666231834554;
	Tue,  1 Sep 2026 19:43:32 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D75E18005B8;
	Tue,  1 Sep 2026 19:43:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Ani Sinha <anisinha@redhat.com>,
	qemu-block@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>,
	Fabiano Rosas <farosas@suse.de>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Peter Xu <peterx@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 00/12] qapi: convert simple command intro sections
Date: Tue,  1 Sep 2026 15:43:12 -0400
Message-ID: <20260901194324.458482-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 1UVuT9b4altyJnCvcCjWYY81RYK3M2ct3tKCravZ6Wg_1788291813
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello, this work converts "simple" intro sections for command=0D
definitions in the QAPI schema to use the new syntax. This is part of=0D
our ongoing effort to add the mythical "inliner" to our generated QMP=0D
documentation.=0D
=0D
"simple" here is a non-technical distinction that means a single=0D
paragraph of text followed by an existing section boundary that=0D
naturally already delineates what comprises the intro.=0D
(This is about 25% of the remaining conversions.)=0D
=0D
If you are a non-QAPI maintainer who has been CC'd on this series,=0D
there is likely very little for you to look at in this series. What=0D
you need to know is that indented paragraphs become part of a=0D
command's "intro" and will appear "above the fold" - above additional=0D
detail in our generated QMP documentation (i.e. features, arguments,=0D
return value, errors, etc) and anything else will eventually appear=0D
"below the fold" - below the detail table, alongside examples, notes,=0D
and more verbose prose.=0D
=0D
As command definitions cannot be inlined by any other definition, the=0D
documentation text for commands will never be re-written or reproduced=0D
in any other context. As such, the distinction between "intro" and=0D
"details" are less important here, but the distinction does still=0D
determine where auto-generated documentation will be inserted, if any:=0D
i.e. features, arguments, and return values will always be inserted=0D
"after the intro".=0D
=0D
John Snow (12):=0D
  qapi: convert simple command intros for ebpf.json=0D
  qapi: convert simple command intros for yank.json=0D
  qapi: convert simple command intros for replay.json=0D
  qapi: convert simple command intros for machine-s390x.json=0D
  qapi: convert simple command intros for dump.json=0D
  qapi: convert simple command intros for block-export.json=0D
  qapi: convert simple command intros for block.json=0D
  qapi: convert simple command intros for cxl.json=0D
  qapi: convert simple command intros for ui.json=0D
  qapi: convert simple command intros for migration.json=0D
  qapi: convert simple command intros for machine.json=0D
  qapi: convert simple command intros for block-core.json=0D
=0D
 qapi/block-core.json    | 96 ++++++++++++++++++++---------------------=0D
 qapi/block-export.json  | 18 ++++----=0D
 qapi/block.json         |  8 ++--=0D
 qapi/cxl.json           | 74 +++++++++++++++----------------=0D
 qapi/dump.json          |  5 +--=0D
 qapi/ebpf.json          |  8 ++--=0D
 qapi/machine-s390x.json |  7 ++-=0D
 qapi/machine.json       | 18 ++++----=0D
 qapi/migration.json     | 51 ++++++++++------------=0D
 qapi/replay.json        | 39 ++++++++---------=0D
 qapi/ui.json            | 11 +++--=0D
 qapi/yank.json          |  5 +--=0D
 12 files changed, 157 insertions(+), 183 deletions(-)=0D
=0D
--=20=0D
2.55.0=0D
=0D

