Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FC637F8B1
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782214; cv=none; b=KoDs3AH/bFyldd5LWbv+HJuLQ1I0PY5Ei0VZ9cW8t0v8itQ++6p/I+XRYH+Pm0iXLhytaHCqsrb4vQkdl3ehEywC0NWAD+cz+Dbti08CB7JvJx5GIWvZr0Bm/aOF6yuB+sb3g2Gno1YGpN4NRBIYe0nF4VZUpXg5NyHDcwTu2KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782214; c=relaxed/simple;
	bh=S/xOOvnSMJVNr6uVpwZDxWnQiSUBbeawxDwswvpDxhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TbnuTY9/THKlCgnvbERFX21U/h8IQbBdXlrpzA/EVhzCeqU5cOnDJfYRqlbeCqbYkwY+isJotjuHWb0NWPX0jqS3ApszmWM4xAr57lML3ZJ5PFe2e+Qok129hrfyHaGbxw5XcNxc3e6hxaU33WDhyYev+fDRvLWDzlFn+/fuw/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1mc+7g1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1mc+7g1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dGgRAyf8YkqROymV/EmTI4vs+Z/0uaTuQevHLTemjt0=;
	b=P1mc+7g1grBI2M9erW0/IQiJ6Bs9YlKf0tlzHlxMdE2QPVJt2ITkeG5VOpwN8Sz522Ew8k
	QAjEfbCMJ3mc0/isGMOfSnhD/c+6+0946OCXEd4nM6wHFGEolHC3QtorTlt0Yf7nnLrXKR
	AA4GdHSKa6v7isguchybgpSEXc7xn3k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-UgicRAdpN1GEard6mXQZZg-1; Thu,
 23 Jul 2026 00:48:24 -0400
X-MC-Unique: UgicRAdpN1GEard6mXQZZg-1
X-Mimecast-MFC-AGG-ID: UgicRAdpN1GEard6mXQZZg_1784782102
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B7C318007D2;
	Thu, 23 Jul 2026 04:48:20 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9123918002AE;
	Thu, 23 Jul 2026 04:48:07 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Lukas Straub <lukasstraub2@web.de>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Zhao Liu <zhao1.liu@intel.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Markus Armbruster <armbru@redhat.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Alex Williamson <alex@shazbot.org>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hanna Reitz <hreitz@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	qemu-block@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	linux-cxl@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	Fabiano Rosas <farosas@suse.de>,
	John Snow <jsnow@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Igor Mammedov <imammedo@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-edac@vger.kernel.org,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	qemu-trivial@nongnu.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 00/44] qapi: convert trivial intro sections
Date: Thu, 23 Jul 2026 00:47:21 -0400
Message-ID: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 1QWnQktYKjDgAYDi3P1qkDIgFe4lTZFA4LLg9F1T-0k_1784782102
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2699067787=0D
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
This patchset tackles "trivial" conversions: cases where the=0D
introduction is only a single paragraph and is immediately followed by=0D
a tagged section, the end of the documentation block, or some other=0D
pre-existing syntactical delineation.=0D
=0D
Future patches that may require more scrutiny will handle the=0D
remaining conversions - I think this is enough for today, don't you?=0D
=0D
John Snow (44):=0D
  qapi: convert intro sections for error.json=0D
  qapi: convert intro sections for acpi-hest.json=0D
  qapi: convert intro sections for ebpf.json=0D
  qapi: convert intro sections for uefi.json=0D
  qapi: convert trivial intro sections for compat.json=0D
  qapi: convert intro sections for vfio.json=0D
  qapi: convert intro sections for trace.json=0D
  qapi: convert trivial intro sections for misc-arm.json=0D
  qapi: convert intro sections for cryptodev.json=0D
  qapi: convert intro sections for machine-common.json=0D
  qapi: convert intro sections for accelerator.json=0D
  qapi: convert intro sections for authz.json=0D
  qapi: convert trivial intro sections for yank.json=0D
  qapi: convert intro sections for replay.json=0D
  qapi: convert trivial intro sections for machine-s390x.json=0D
  qapi: convert trivial intro sections for acpi.json=0D
  qapi: convert intro sections for tpm.json=0D
  qapi: convert trivial intro sections for qdev.json=0D
  qapi: convert trivial intro sections for control.json=0D
  qapi: convert intro sections for dump.json=0D
  qapi: convert intro sections for common.json=0D
  qapi: convert intro sections for sockets.json=0D
  qapi: convert trivial intro sections for transaction.json=0D
  qapi: convert trivial intro sections for stats.json=0D
  qapi: convert trivial intro sections for job.json=0D
  qapi: convert intro sections for pci.json=0D
  qapi: convert trivial intro sections for introspect.json=0D
  qapi: convert intro sections for rocker.json=0D
  qapi: convert trivial intro sections for misc-i386.json=0D
  qapi: convert trivial intro sections for block-export.json=0D
  qapi: convert intro sections for audio.json=0D
  qapi: convert trivial intro sections for block.json=0D
  qapi: convert trivial intro sections for misc.json=0D
  qapi: convert trivial intro sections for crypto.json=0D
  qapi: convert intro sections for cxl.json=0D
  qapi: convert trivial intro sections for run-state.json=0D
  qapi: convert intro sections for char.json=0D
  qapi: convert intro sections for virtio.json=0D
  qapi: convert trivial intro sections for net.json=0D
  qapi: convert trivial intro sections for qom.json=0D
  qapi: convert trivial intro sections for ui.json=0D
  qapi: convert trivial intro sections for migration.json=0D
  qapi: convert trivial intro sections for machine.json=0D
  qapi: convert trivial intro sections for block-core.json=0D
=0D
 qapi/accelerator.json    |  18 +-=0D
 qapi/acpi-hest.json      |   4 +-=0D
 qapi/acpi.json           |  15 +-=0D
 qapi/audio.json          |  88 ++----=0D
 qapi/authz.json          |  21 +-=0D
 qapi/block-core.json     | 646 ++++++++++++++++-----------------------=0D
 qapi/block-export.json   |  87 +++---=0D
 qapi/block.json          |  58 ++--=0D
 qapi/char.json           |  90 ++----=0D
 qapi/common.json         |  36 +--=0D
 qapi/compat.json         |   6 +-=0D
 qapi/control.json        |  30 +-=0D
 qapi/crypto.json         | 118 +++----=0D
 qapi/cryptodev.json      |  18 +-=0D
 qapi/cxl.json            | 128 ++++----=0D
 qapi/dump.json           |  24 +-=0D
 qapi/ebpf.json           |  14 +-=0D
 qapi/error.json          |   3 +-=0D
 qapi/introspect.json     |  45 +--=0D
 qapi/job.json            |  18 +-=0D
 qapi/machine-common.json |  19 +-=0D
 qapi/machine-s390x.json  |  20 +-=0D
 qapi/machine.json        | 261 ++++++----------=0D
 qapi/migration.json      | 201 +++++-------=0D
 qapi/misc-arm.json       |  15 +-=0D
 qapi/misc-i386.json      |  52 ++--=0D
 qapi/misc.json           |  74 ++---=0D
 qapi/net.json            | 101 +++---=0D
 qapi/pci.json            |  27 +-=0D
 qapi/qdev.json           |  23 +-=0D
 qapi/qom.json            | 138 +++------=0D
 qapi/replay.json         |  45 ++-=0D
 qapi/rocker.json         |  39 +--=0D
 qapi/run-state.json      | 120 +++-----=0D
 qapi/sockets.json        |  31 +-=0D
 qapi/stats.json          |  34 +--=0D
 qapi/tpm.json            |  29 +-=0D
 qapi/trace.json          |  12 +-=0D
 qapi/transaction.json    |  14 +-=0D
 qapi/uefi.json           |   5 +-=0D
 qapi/ui.json             | 215 +++++--------=0D
 qapi/vfio.json           |  19 +-=0D
 qapi/virtio.json         |  91 +++---=0D
 qapi/yank.json           |  25 +-=0D
 44 files changed, 1165 insertions(+), 1912 deletions(-)=0D
=0D
--=20=0D
2.55.0=0D
=0D

