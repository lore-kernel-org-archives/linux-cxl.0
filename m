Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266843FD960
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506889; cv=none; b=aFhZ3C9pICl4f3nnIzTkBm3M1Ti1vsCwGZWiKT7qywRVX2cmRyIu/ElJNtlg9WVp4l+mwb96cHVtAvQmRNprLRbEVivF5v/F8+29KtF9XyIyk1FepeC09hVvgt3Pjme/mv19Gx5naAdUJ2V/rgob4lL5uDw5qdDpvkkoMufpIRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506889; c=relaxed/simple;
	bh=i8uJ9z3XddMM9Ts/f0wIxgRKMKrhwEv9tdstkfBy0J4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EJSRA2zYcrFdhWdFVp3gNJ9SB0JulEPboe9FAyguAw0AZ6ohhL2O60radAz7tpterNUgJKIO3Gd45r7HvsA+1mfSH3RNhcfg0nFRUni6D47X0s/QKqA5GY2nY0hQY3iuhDRq7DAlyzEZLLqPlfwgylmAaAZ1vdan8zzNsMgJFBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tr0TVZiR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tr0TVZiR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789506887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z//KRP7i0YRSeB64k0G82iRyA5bNJAjXHoRXbOeSML0=;
	b=Tr0TVZiRvIDZ7L8eAj71nFf5eJeeJiIPxtfw+8sK/4R6DBOWXYczMP2hPMt+d+vA4er0lW
	AE+sEUqVy2Njw64vidbCLf2mKNmfPM5TAbwhG6hMmAnZkjzq5Xr5jrfWgOEOqdMUyJvitV
	D7caoWzmwYfSP7UgyETFEp4YTm4jbCU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-YyAlon3BMlKTjyMlMZNt6g-1; Tue,
 15 Sep 2026 17:14:43 -0400
X-MC-Unique: YyAlon3BMlKTjyMlMZNt6g-1
X-Mimecast-MFC-AGG-ID: YyAlon3BMlKTjyMlMZNt6g_1789506881
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8A9018088B7;
	Tue, 15 Sep 2026 21:14:40 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EB5DB1956095;
	Tue, 15 Sep 2026 21:14:35 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Markus Armbruster <armbru@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Hanna Reitz <hreitz@redhat.com>,
	qemu-block@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>,
	linux-cxl@vger.kernel.org,
	Lukas Straub <lukasstraub2@web.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Michael Roth <michael.roth@amd.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eric Blake <eblake@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Junjie Cao <junjie.cao@intel.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v3 0/7] qapi: convert remaining "simple" intro sections
Date: Tue, 15 Sep 2026 17:14:27 -0400
Message-ID: <20260915211434.3511110-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: iVED7h8NMxziTiFrwZa-dzvjAXV8hC6_tjtTp36uMDc_1789506881
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

v3:=0D
 - Fix python typing issue with hotfix from below ...=0D
 - Rebase on top of armbru/qapi-not-next=0D
v2:=0D
 - Fix stub insertion algorithm for some "TODO:" replacement cases=0D
=0D
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
John Snow (7):=0D
  qapi: convert remaining simple intros for block-export.json=0D
  qapi: convert remaining simple intros for cxl.json=0D
  qapi: convert remaining simple intros for machine.json=0D
  qapi: convert remaining simple intros for block-core.json=0D
  qapi/parser: fix intermediate "intro" detection=0D
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
 scripts/qapi/parser.py |  7 +++++++=0D
 10 files changed, 61 insertions(+), 88 deletions(-)=0D
=0D
--=20=0D
2.55.0=0D
=0D

