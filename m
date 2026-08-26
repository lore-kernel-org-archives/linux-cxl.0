Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6304779B2
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773160; cv=none; b=vF3DwnShMgW806PchwHJD0i2A4tbB1sy159O2H1Q9qH8hMsXgSc85Wz4wWJzlaPMVYt1gFJ2x6ST3I7DG+nyz/L6j2yO3IUKRJOaOVKGJOXCNnssR6x31MRETXniR1kjYMLOfbmNtijNS7YHFev6yQueGewN7xU7mFMg6yHinP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773160; c=relaxed/simple;
	bh=tL87ZccIz1sUZFUXU1IBQMWC/0mvRYi6oOJ9PRqxeFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cFH1mcwPUqvSx3yROE1/oIbPDeoEBeXywJZqsAJsIw/7XMRAZd9oUrjA4mMU011HmxcaMxvAslErJU+3ENCfw16zRh1I8xKS3rM0tNPXtdJvpW5LZJEnKCLUD+Qkyg93k9P3xT1QZhbVkzCMOA0pKzPwgZ7WuDHrE+IfQxtynyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INJBPvf+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INJBPvf+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s9bozq2A418taG1qUgS13udO0wiNcqkTCymptFTx+vw=;
	b=INJBPvf+rhRFEkJqLQuRpTE1ZSZ98sVbsLdMaZYm861Ag8MVev0AkhfeC9fZQ/lHGnDGS9
	SYsCM/j5NN1THHm4sKMGRnRILYxLIXYemckG7R1AyoxpQh2UWHyiU3uvuwt4JjKRSemRsv
	FNGt2LGZBP500yWAzX/8bk9aGwnba00=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-9412ylJcNfqNWpF-vOfexA-1; Wed,
 26 Aug 2026 15:38:58 -0400
X-MC-Unique: 9412ylJcNfqNWpF-vOfexA-1
X-Mimecast-MFC-AGG-ID: 9412ylJcNfqNWpF-vOfexA_1787773135
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71265180134D;
	Wed, 26 Aug 2026 19:38:54 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE7BC1800577;
	Wed, 26 Aug 2026 19:38:41 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	John Snow <jsnow@redhat.com>,
	linux-cxl@vger.kernel.org,
	Markus Armbruster <armbru@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	qemu-trivial@nongnu.org,
	Fabiano Rosas <farosas@suse.de>,
	Kevin Wolf <kwolf@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Jiri Pirko <jiri@resnulli.us>,
	qemu-block@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	linux-edac@vger.kernel.org,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Zhao Liu <zhao1.liu@intel.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Lukas Straub <lukasstraub2@web.de>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 00/43] qapi: convert (very) trivial intro sections
Date: Wed, 26 Aug 2026 15:37:57 -0400
Message-ID: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: _xJRJmEnt5ettHdY_7uHX3UGPcZDC40C3ypRMw-4w28_1787773135
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

v3:=0D
   As per Markus' request, the intro section conversion has been split=0D
   even further into the *very* trivial; leaving the semi-trivial and=0D
   not-trivial conversions for later consideration.=0D
=0D
   If you are a non-qapi/non-docs maintainer being CC'd on this patch,=0D
   there is **very likely** nothing for you to do here; we are only=0D
   changing spacing and syntax, but not modifying content in any way=0D
   in this series in particular. Please feel free to mark-as-read and=0D
   move on with your day.=0D
=0D
-=0D
=0D
Hi, this patchset converts trivial "introductory" sections in the QAPI=0D
documentation to use the new, explicit intro section syntax.=0D
=0D
This is being done primarily for the benefit of the forthcoming=0D
"inliner", a feature for the rendered HTML QMP documentation that=0D
seeks to "inline" QMP command argument documentation into the argument=0D
list for each command.=0D
=0D
There are two main motives here:=0D
=0D
(1) We want the split between the "introduction" and "details"=0D
    sections to be mechanically obvious, so that auto-generated or=0D
    inlined documentation has a well-defined, obvious spot to go.=0D
=0D
(2) We do not want to inline irrelevant, introductory text describing=0D
    structures to be copied into command documentation.=0D
=0D
This patchset tackles "very trivial" conversions: cases where the=0D
existing leading plaintext is only a single sentence and is=0D
immediately followed by a tagged section, the end of the documentation=0D
block, or some other pre-existing syntactical delineation. (i.e.: not=0D
more plaintext.)=0D
=0D
NOTE: This series *may* miss some conversions; future QAPI changes will=0D
enforce the new syntax and any cases that have appeared since v1 will=0D
be identified and corrected at that time; we are concerned with the=0D
bulk and ease-of-review here, not completeness. This is precisely why=0D
the new intro syntax and parser were carefully designed to allow=0D
gradual conversion.=0D
=0D
NOTE2: Future patches that may require more scrutiny will handle the=0D
remaining conversions - There are some very subtle concerns that are=0D
not readily apparent in the very minor textual changes that will be=0D
spelled out for reviewers in the cover letters for those series.=0D
=0D
This is enough for today, don't you think?=0D
=0D
John Snow (43):=0D
  qapi: convert trivial intro sections for error.json=0D
  qapi: convert trivial intro sections for acpi-hest.json=0D
  qapi: convert trivial intro sections for ebpf.json=0D
  qapi: convert trivial intro sections for compat.json=0D
  qapi: convert trivial intro sections for vfio.json=0D
  qapi: convert trivial intro sections for trace.json=0D
  qapi: convert trivial intro sections for misc-arm.json=0D
  qapi: convert trivial intro sections for cryptodev.json=0D
  qapi: convert trivial intro sections for machine-common.json=0D
  qapi: convert trivial intro sections for accelerator.json=0D
  qapi: convert trivial intro sections for authz.json=0D
  qapi: convert trivial intro sections for yank.json=0D
  qapi: convert trivial intro sections for replay.json=0D
  qapi: convert trivial intro sections for machine-s390x.json=0D
  qapi: convert trivial intro sections for acpi.json=0D
  qapi: convert trivial intro sections for tpm.json=0D
  qapi: convert trivial intro sections for qdev.json=0D
  qapi: convert trivial intro sections for control.json=0D
  qapi: convert trivial intro sections for dump.json=0D
  qapi: convert trivial intro sections for common.json=0D
  qapi: convert trivial intro sections for sockets.json=0D
  qapi: convert trivial intro sections for transaction.json=0D
  qapi: convert trivial intro sections for stats.json=0D
  qapi: convert trivial intro sections for job.json=0D
  qapi: convert trivial intro sections for pci.json=0D
  qapi: convert trivial intro sections for introspect.json=0D
  qapi: convert trivial intro sections for rocker.json=0D
  qapi: convert trivial intro sections for misc-i386.json=0D
  qapi: convert trivial intro sections for block-export.json=0D
  qapi: convert trivial intro sections for audio.json=0D
  qapi: convert trivial intro sections for block.json=0D
  qapi: convert trivial intro sections for misc.json=0D
  qapi: convert trivial intro sections for crypto.json=0D
  qapi: convert trivial intro sections for cxl.json=0D
  qapi: convert trivial intro sections for run-state.json=0D
  qapi: convert trivial intro sections for char.json=0D
  qapi: convert trivial intro sections for virtio.json=0D
  qapi: convert trivial intro sections for net.json=0D
  qapi: convert trivial intro sections for qom.json=0D
  qapi: convert trivial intro sections for ui.json=0D
  qapi: convert trivial intro sections for migration.json=0D
  qapi: convert trivial intro sections for machine.json=0D
  qapi: convert trivial intro sections for block-core.json=0D
=0D
 qapi/accelerator.json    |  18 +-=0D
 qapi/acpi-hest.json      |   4 +-=0D
 qapi/acpi.json           |   8 +-=0D
 qapi/audio.json          |  88 +++-----=0D
 qapi/authz.json          |  21 +-=0D
 qapi/block-core.json     | 448 ++++++++++++++-------------------------=0D
 qapi/block-export.json   |  50 ++---=0D
 qapi/block.json          |  41 ++--=0D
 qapi/char.json           |  90 +++-----=0D
 qapi/common.json         |  29 +--=0D
 qapi/compat.json         |   6 +-=0D
 qapi/control.json        |  30 +--=0D
 qapi/crypto.json         | 100 ++++-----=0D
 qapi/cryptodev.json      |  18 +-=0D
 qapi/cxl.json            |   6 +-=0D
 qapi/dump.json           |  19 +-=0D
 qapi/ebpf.json           |   6 +-=0D
 qapi/error.json          |   3 +-=0D
 qapi/introspect.json     |  40 ++--=0D
 qapi/job.json            |  18 +-=0D
 qapi/machine-common.json |  14 +-=0D
 qapi/machine-s390x.json  |  13 +-=0D
 qapi/machine.json        | 208 +++++++-----------=0D
 qapi/migration.json      | 131 +++++-------=0D
 qapi/misc-arm.json       |   6 +-=0D
 qapi/misc-i386.json      |  52 ++---=0D
 qapi/misc.json           |  74 +++----=0D
 qapi/net.json            |  92 +++-----=0D
 qapi/pci.json            |  27 +--=0D
 qapi/qdev.json           |  14 +-=0D
 qapi/qom.json            | 150 +++++--------=0D
 qapi/replay.json         |   6 +-=0D
 qapi/rocker.json         |  39 ++--=0D
 qapi/run-state.json      | 113 ++++------=0D
 qapi/sockets.json        |  31 ++-=0D
 qapi/stats.json          |  34 ++-=0D
 qapi/tpm.json            |  29 +--=0D
 qapi/trace.json          |  12 +-=0D
 qapi/transaction.json    |  14 +-=0D
 qapi/ui.json             | 199 ++++++-----------=0D
 qapi/vfio.json           |   4 +-=0D
 qapi/virtio.json         |  54 ++---=0D
 qapi/yank.json           |   5 +-=0D
 43 files changed, 845 insertions(+), 1519 deletions(-)=0D
=0D
--=20=0D
2.55.0=0D
=0D

