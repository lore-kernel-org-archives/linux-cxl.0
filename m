Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AC04C10FD
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789674398; cv=none; b=VmYvdoUbu5WOMQd7BtrRd3z2Y5ScF3cCJNMgBJHreEXIRPb3/8ZgMY/3+7HvjufdeIr65iufu6j4bNByy0sp6HksYlLKSCns6ZV3KW/34qgJJ9bFHshjCXWG4w3UDx82IvmUOWB8OD6SEVccQ/BJjVzJhl5XF2n7vEsIhpA/qRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789674398; c=relaxed/simple;
	bh=H3P4SC3MUohqyrA25rofFFzKpQih/U9UWvaO8gUOGGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=hjFZg1gLbf8/u9hepD13IJHFASMnn5axFlNN1jotgE8F58M7HsRraCkBk3MY5wgrPSS8DVwoQW1DSlZSmFpH2xsVMzufKmasj+nAacl6VASD09+qec6KTIp8MmY6OTIoDj99Rxh8fI/dbUvw/l3+j1gzG1ebENsRvEkgsmNO+Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drrIonLF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drrIonLF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789674394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NKPSpHSAdUW0sNBcwRZtBbtyHQtLc8C/jg53CK8yBGQ=;
	b=drrIonLFhzR7rdbOQZtRZ8lLr8Jot24YYCXEncOOBXClsA6M0Yv8gluaDXU7NO2B4SaelD
	wm8G9OlDMAEdUdEqXy2kgM7ouvyQYnDo4PiwPwRJNPPY7ve4IzlAgYBMI3Wprj5cOZV3es
	yJ4ahvPqQibHwVNaMh5HHTogJCF4Vhk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-TM3mgJ4SOfGO3P_EUkG7TA-1; Thu,
 17 Sep 2026 15:46:31 -0400
X-MC-Unique: TM3mgJ4SOfGO3P_EUkG7TA-1
X-Mimecast-MFC-AGG-ID: TM3mgJ4SOfGO3P_EUkG7TA_1789674389
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 304EA1964CD4;
	Thu, 17 Sep 2026 19:46:29 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.85])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4AA0C19AC048;
	Thu, 17 Sep 2026 19:46:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Junjie Cao <junjie.cao@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	linux-cxl@vger.kernel.org,
	Jason Wang <jasowangio@gmail.com>,
	Eric Blake <eblake@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	qemu-block@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Lukas Straub <lukasstraub2@web.de>,
	Jonathan Cameron <jic23@kernel.org>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v5 3/7] qapi: convert remaining simple intros for machine.json
Date: Thu, 17 Sep 2026 15:46:10 -0400
Message-ID: <20260917194614.549584-4-jsnow@redhat.com>
In-Reply-To: <20260917194614.549584-1-jsnow@redhat.com>
References: <20260917194614.549584-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: lNoQ4e1Xv-J50fzW7Fv3o04iR2YSd0xQyl4rgGhNE7w_1789674389
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

These are either structs or unions that are used in an inlinable
context: i.e. the generated documentation is likely to feature a
version of this documentation block that does not include the intro in
context of another command, event, or structure.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine.json | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index f1f2c393824..a58e373dd70 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -449,8 +449,7 @@
 
 ##
 # @NumaOptions:
-#
-# A discriminated record of NUMA options.  (for OptsVisitor)
+#     A discriminated record of NUMA options.  (for OptsVisitor)
 #
 # @type: NUMA option type
 #
-- 
2.55.0

