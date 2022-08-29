Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A613C0502C
	for <linux-cxl@archiver.kernel.org>; Mon, 29 Aug 2022 23:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiH2XmE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 29 Aug 2022 19:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiH2XmD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 29 Aug 2022 19:42:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA708A1DE
        for <linux-cxl@vger.kernel.org>; Mon, 29 Aug 2022 16:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661816522; x=1693352522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zETNzIlWgWJnq6zD3rw2Rep/FF/MNXsxnk/+JMc/YRc=;
  b=ZJRcASWhasV4kCyHpFjtbsicXAthlI4TCQDFyeho2o8FSKzJCWJEHlJk
   dtSJI5hmlUGaXCg+4XUXALJNA9ryqUuuAC9iUoAKNFYgvQ8f5tPhUORof
   NwoDLDzKHpw7aLtzoHGdhyMErLeyjmHlsAlSx1RpHay2DxQNNRFZ3r53Z
   xM489Ijs5Lcr9rS5y43w7SlsF11/v1J2fLCJ4VSgKvtkxFqwGh3BOqzlO
   D87gCrqPlyO8u429poOQC+gDef133BVYQdE9gT1M6Ne7orhqh8WdHnHoB
   RuIZdhH8LuYMJkXBGVrFsiWq11VRizGFiek4lJViI5JYMIfwKqWALM0Bu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="321150961"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="321150961"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 16:42:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="588358119"
Received: from kmora1-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.213.169.48])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 16:42:01 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <nvdimm@lists.linux.dev>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        corsepiu@fedoraproject.org, <linux-cxl@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH 2/2] scripts: update release scripts for meson
Date:   Mon, 29 Aug 2022 17:41:57 -0600
Message-Id: <20220829234157.101085-3-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220829234157.101085-1-vishal.l.verma@intel.com>
References: <20220829234157.101085-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4925; h=from:subject; bh=zETNzIlWgWJnq6zD3rw2Rep/FF/MNXsxnk/+JMc/YRc=; b=owGbwMvMwCXGf25diOft7jLG02pJDMm8fkflXxpkLxSbUuGldGGCS9KUmVcjRRViH+YE1Tbvkvz/ ODmgo5SFQYyLQVZMkeXvno+Mx+S25/MEJjjCzGFlAhnCwMUpABNZy8zIMOXO1yv+FVXd3dN4C22W2d klPb+WFL2P8+KbGw2p969mrWZkmBnwle3axTQ56aMXJGqC3kqx2fyIPW1cHe41O2nLTPFeXgA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Update scripts/prepare-release and scripts/do_abidiff to use meson, and
change the expected branch name from 'master' to 'main'.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 scripts/do_abidiff         | 14 ++++++--------
 scripts/prepare-release.sh | 24 ++++++++++++------------
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/scripts/do_abidiff b/scripts/do_abidiff
index ec3e344..cb60e23 100755
--- a/scripts/do_abidiff
+++ b/scripts/do_abidiff
@@ -17,13 +17,11 @@ build_rpm()
 	local version=""
 
 	# prepare ndctl tree
-	rm -rf results_ndctl
+	rm -rf results_ndctl build
 	git checkout -b rel_${ref} $ref
-	./autogen.sh
-	./configure CFLAGS='-g -O2' --prefix=/usr --sysconfdir=/etc --libdir=/usr/lib64
-	make clean
-	make rhel/ndctl.spec
-	cp rhel/ndctl.spec .
+	meson setup build
+	meson compile -C build rhel/ndctl.spec
+	cp build/rhel/ndctl.spec .
 
 	# build and copy RPMs
 	version="$(./git-version)"
@@ -46,8 +44,8 @@ build_rpm()
 do_diff()
 {
 	local pkg="$1"
-	local old_base="$(find . -regex "./release/rel_${old}/${pkg}-[0-9]+.*" | head -1)"
-	local new_base="$(find . -regex "./release/rel_${new}/${pkg}-[0-9]+.*" | head -1)"
+	local old_base="$(find . -regex "./release/rel_${old}/${pkg}[-cli]*-[0-9]+.*" | head -1)"
+	local new_base="$(find . -regex "./release/rel_${new}/${pkg}[-cli]*-[0-9]+.*" | head -1)"
 	local old_dev="$(find . -regex "./release/rel_${old}/${pkg}-devel-[0-9]+.*" | head -1)"
 	local new_dev="$(find . -regex "./release/rel_${new}/${pkg}-devel-[0-9]+.*" | head -1)"
 	local old_lib="$(find . -regex "./release/rel_${old}/${pkg}-libs-[0-9]+.*" | head -1)"
diff --git a/scripts/prepare-release.sh b/scripts/prepare-release.sh
index 8901b50..c8f54dc 100755
--- a/scripts/prepare-release.sh
+++ b/scripts/prepare-release.sh
@@ -6,7 +6,7 @@
 
 # Notes:
 #  - Checkout to the appropriate branch beforehand
-#     master - for major release
+#     main - for major release
 #     ndctl-xx.y - for fixup release
 #    This is important for generating the shortlog
 #  - Add a temporary commit that updates the libtool versions as needed.
@@ -50,9 +50,9 @@ check_branch()
 			err "expected an ndctl-xx.y branch for fixup release"
 		fi
 	else
-		# major release, expect master branch
-		if ! grep -Eq "^master$" <<< "$cur"; then
-			err "expected master branch for a major release"
+		# major release, expect main branch
+		if ! grep -Eq "^main$" <<< "$cur"; then
+			err "expected main branch for a major release"
 		fi
 	fi
 	if ! git diff-index --quiet HEAD --; then
@@ -99,7 +99,7 @@ gen_lists()
 	c_count=$(git log --pretty=format:"%s" "$range" | wc -l)
 }
 
-# Check libtool versions in Makefile.am.in
+# Check libtool versions in meson.build
 # $1: lib name (currently libndctl, libdaxctl, or libcxl)
 check_libtool_vers()
 {
@@ -107,13 +107,13 @@ check_libtool_vers()
 	local lib_u="${lib^^}"
 	local libdir="${lib##lib}/lib/"
 	local symfile="${libdir}/${lib}.sym"
-	local last_cur=$(git show $last_ref:Makefile.am.in | grep -E "^${lib_u}_CURRENT" | cut -d'=' -f2)
-	local last_rev=$(git show $last_ref:Makefile.am.in | grep -E "^${lib_u}_REVISION" | cut -d'=' -f2)
-	local last_age=$(git show $last_ref:Makefile.am.in | grep -E "^${lib_u}_AGE" | cut -d'=' -f2)
+	local last_cur=$(git show $last_ref:meson.build | grep -E "^${lib_u}_CURRENT" | cut -d'=' -f2)
+	local last_rev=$(git show $last_ref:meson.build | grep -E "^${lib_u}_REVISION" | cut -d'=' -f2)
+	local last_age=$(git show $last_ref:meson.build | grep -E "^${lib_u}_AGE" | cut -d'=' -f2)
 	local last_soname=$((last_cur - last_age))
-	local next_cur=$(git show HEAD:Makefile.am.in | grep -E "^${lib_u}_CURRENT" | cut -d'=' -f2)
-	local next_rev=$(git show HEAD:Makefile.am.in | grep -E "^${lib_u}_REVISION" | cut -d'=' -f2)
-	local next_age=$(git show HEAD:Makefile.am.in | grep -E "^${lib_u}_AGE" | cut -d'=' -f2)
+	local next_cur=$(git show HEAD:meson.build | grep -E "^${lib_u}_CURRENT" | cut -d'=' -f2)
+	local next_rev=$(git show HEAD:meson.build | grep -E "^${lib_u}_REVISION" | cut -d'=' -f2)
+	local next_age=$(git show HEAD:meson.build | grep -E "^${lib_u}_AGE" | cut -d'=' -f2)
 	local next_soname=$((next_cur - next_age))
 	local soname_diff=$((next_soname - last_soname))
 
@@ -195,6 +195,6 @@ sed -i -e "s/DEF_VER=[0-9]\+.*/DEF_VER=${next_ref#v}/" git-version
 echo "Ready to release ndctl-$next_ref with $c_count new commits."
 echo "Add git-version to the top commit to get the updated version."
 echo "Use release/commits and release/shortlog to compose the release message"
-echo "The release commit typically contains the Makefile.am.in libtool version"
+echo "The release commit typically contains the meson.build libtool version"
 echo "update, and the git-version update."
 echo "Finally, ensure the release commit as well as the tag are PGP signed."
-- 
2.37.2

